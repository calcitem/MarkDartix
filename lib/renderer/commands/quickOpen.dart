import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_package_name/util.dart';
import 'package:your_package_name/bus.dart';
import 'package:your_package_name/file_searcher.dart';
import 'package:path/path.dart' as path;

final RegExp specialChars = RegExp(r'[\[\]\\^$.\|\?\*\+\(\)\/]{1}');

class QuickOpenCommand {
  String id = 'file.quick-open';
  String description = 'File: Quick Open';
  String placeholder = 'Search file to open';
  String? shortcut;

  List<dynamic> subcommands = [];
  int subcommandSelectedIndex = -1;

  dynamic _editorState;
  dynamic _folderState;

  FileSearcher _directorySearcher = FileSearcher();
  Function? _cancelFn;

  QuickOpenCommand(this._editorState, this._folderState);

  Future<List<dynamic>> search(String query) async {
    if (query.isEmpty) {
      return subcommands;
    }

    if (_cancelFn != null) {
      _cancelFn!();
      _cancelFn = null;
    }

    final timeout = delay(Duration(milliseconds: 300));
    _cancelFn = () {
      timeout.cancel();
      _cancelFn = null;
    };

    await timeout;
    return _doSearch(query);
  }

  Future<void> run() async {
    if (_folderState['projectTree'] == null &&
        _editorState['tabs'].length == 0) {
      throw Error();
    }

    subcommands = _editorState['tabs']
        .map((t) => t['pathname'])
        .where((t) => t != null)
        .map((pathname) {
      final item = {'id': pathname};
      item.addAll(_getPath(pathname));
      return item;
    }).toList();
  }

  Future<void> execute() async {
    await delay(Duration(milliseconds: 100));
    bus.emit('show-command-palette', this);
  }

  Future<void> executeSubcommand(String id) async {
    // Emit event with your platform channel implementation.
    // Replace "yourMethodChannel" with your actual MethodChannel instance.
    await yourMethodChannel.invokeMethod('mt::open-file-by-window-id', id);
  }

  void unload() {
    subcommands = [];
  }

  Future<List<dynamic>> _doSearch(String query) async {
    _cancelFn = null;
    final bool isRootDirOpened = _folderState['projectTree'] != null;
    final bool tabsAvailable = _editorState['tabs'].length > 0;

    if (!isRootDirOpened && !tabsAvailable) {
      return [];
    }

    List<String> searchResult = [];
    String? rootPath =
        isRootDirOpened ? _folderState['projectTree']['pathname'] : null;

    if (tabsAvailable) {
      RegExp re = RegExp(
          query.replaceAll(specialChars, (p) {
            if (p == '*') return '.*';
            return p == '\\' ? '\\\\' : '\\${p}';
          }),
          caseSensitive: false);

      for (final tab in _editorState['tabs']) {
        final String? pathname = tab['pathname'];
        if (pathname != null &&
            re.hasMatch(pathname) &&
            (!rootPath!.contains(pathname))) {
          searchResult.add(pathname);
        }
      }
    }

    if (!isRootDirOpened) {
      return searchResult
          .map((pathname) => {
                'id': pathname,
                'description': pathname,
                'title': pathname,
              })
          .toList();
    }

    Completer<List<dynamic>> completer = Completer();
    bool canceled = false;

    _directorySearcher.search([rootPath], '', (result) {
      if (!canceled) {
        searchResult.add(result);
      }
    }, (_) {
      if (!canceled && searchResult.length > 30) {
        canceled = true;
        _directorySearcher.cancel();
      }
    }, _getInclusions(query)).then((_) {
      _cancelFn = null;
      completer.complete(
        searchResult.map((pathname) {
          final item = {'id': pathname};
          item.addAll(_getPath(pathname));
          return item;
        }).toList(),
      );
    }).catchError((error) {
      _cancelFn = null;
      completer.completeError(error);
    });

    _cancelFn = () {
      _cancelFn = null;
      canceled = true;
      _directorySearcher.cancel();
    };

    return completer.future;
  }

  List<String> _getInclusions(String query) {
    if (hasMarkdownExtension(query)) {
      return ['*${query}'];
    }

    List<String> inclusions = [];
    for (int i = 0; i < markdownInclusions.length; ++i) {
      inclusions[i] = '*${query}' + markdownInclusions[i];
    }
    return inclusions;
  }

  Map<String, String> _getPath(String pathname) {
    String rootPath = _folderState['projectTree']['pathname'];
    if (!rootPath.contains(pathname)) {
      return {'title': pathname, 'description': pathname};
    }

    String p = path.relative(rootPath, pathname);
    Map<String, String> item = {'description': p};
    if (p.length > 50) {
      item['title'] = p;
    }
    return item;
  }
}
