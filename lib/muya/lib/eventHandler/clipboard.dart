import 'dart:html';
import 'package:muya/muya.dart';

class Clipboard {
  Muya muya;
  String _copyType;
  String _pasteType;
  dynamic _copyInfo;

  Clipboard(Muya muya) {
    this.muya = muya;
    this._copyType = 'normal';
    this._pasteType = 'normal';
    this._copyInfo = null;
    listen();
  }

  void listen() {
    final container = muya.container;
    final eventCenter = muya.eventCenter;
    final contentState = muya.contentState;

    void docPasteHandler(Event event) {
      contentState.docPasteHandler(event);
    }

    void docCopyCutHandler(Event event) {
      contentState.docCopyHandler(event);
      if (event.type == 'cut') {
        contentState.docCutHandler(event);
      }
    }

    void copyCutHandler(Event event) {
      contentState.copyHandler(event, _copyType, _copyInfo);
      if (event.type == 'cut') {
        contentState.cutHandler();
      }
      _copyType = 'normal';
    }

    void pasteHandler(Event event) {
      contentState.pasteHandler(event, _pasteType);
      _pasteType = 'normal';
      muya.dispatchChange();
    }

    eventCenter.attachDOMEvent(document, 'paste', docPasteHandler);
    eventCenter.attachDOMEvent(container, 'paste', pasteHandler);
    eventCenter.attachDOMEvent(container, 'cut', copyCutHandler);
    eventCenter.attachDOMEvent(container, 'copy', copyCutHandler);
    eventCenter.attachDOMEvent(document.body!, 'cut', docCopyCutHandler);
    eventCenter.attachDOMEvent(document.body!, 'copy', docCopyCutHandler);
  }

  // TODO: `document.execCommand` is deprecated!

  void copyAsMarkdown() {
    _copyType = 'copyAsMarkdown';
    document.execCommand('copy');
  }

  void copyAsHtml() {
    _copyType = 'copyAsHtml';
    document.execCommand('copy');
  }

  void pasteAsPlainText() {
    _pasteType = 'pasteAsPlainText';
    document.execCommand('paste');
  }

  /**
   * Copy the anchor block(table, paragraph, math block etc) with the info
   * @param {string|object} type copyBlock or copyCodeContent
   * @param {string|object} info  is the block key if it's string, or block if it's object
   */
  void copy(String type, dynamic info) {
    _copyType = type;
    _copyInfo = info;
    document.execCommand('copy');
  }
}
