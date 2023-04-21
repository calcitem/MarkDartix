import 'dart:async';
import 'dart:html' as html;
import 'dart:io';
import 'package:flutter/material.dart';

class ContentState {
  GlobalKey<EditableTextState>? editableTextKey;
  dynamic dropAnchor;

  ContentState({this.editableTextKey});

  void hideGhost() {
    dropAnchor = null;
    html.DivElement? ghost = html.querySelector('#mu-dragover-ghost');
    ghost?.remove();
  }

  void createGhost(html.MouseEvent event) {
    html.Element? target = event.target as html.Element?;
    html.DivElement? ghost = null;
    // TODO: Implement the logic for findNearestParagraph and findOutMostParagraph
    // You may need to create separate methods for these and replace them with the actual method names below.
    html.Element? nearestParagraph = findNearestParagraph(target);
    html.Element? outmostParagraph = findOutMostParagraph(target);

    if (outmostParagraph == null) {
      return hideGhost();
    }

    // TODO: Implement the logic for getBlock and getAnchor
    // You may need to create separate methods for these and replace them with the actual method names below.
    dynamic block = getBlock(nearestParagraph!.id);
    dynamic anchor = getAnchor(block);

    if (!anchor && outmostParagraph != null) {
      anchor = getBlock(outmostParagraph.id);
    }

    if (anchor != null) {
      // TODO: Implement the logic for muya
      // You may need to create a separate class or object for Muya and replace it with the actual object below.
      html.Element? anchorParagraph =
          muya.container.querySelector('#${anchor.key}');
      html.Rectangle rect = anchorParagraph!.getBoundingClientRect();
      String position = verticalPositionInRect(event, rect);
      dropAnchor = {'position': position, 'anchor': anchor};

      ghost = html.querySelector('#mu-dragover-ghost') as html.DivElement?;
      if (ghost == null) {
        ghost = html.DivElement();
        ghost.id = 'mu-dragover-ghost';
        html.document.body!.append(ghost);
      }

      ghost.style
        ..width = '${rect.width}px'
        ..left = '${rect.left}px'
        ..top = position == 'up'
            ? '${rect.top - 3}px'
            : '${rect.top + rect.height}px';
    }
  }

  void dragoverHandler(html.MouseEvent event) {
    // Cancel to allow tab drag&drop.
    if (event.dataTransfer!.types!.isEmpty) {
      event.dataTransfer!.dropEffect = 'none';
      return;
    }

    if (event.dataTransfer!.types!.contains('text/uri-list')) {
      List<html.DataTransferItem> items = List.from(event.dataTransfer!.items!);
      bool hasUriItem = items.any((item) => item.type == 'text/uri-list');
      bool hasTextItem = items.any((item) => item.type == 'text/plain');
      bool hasHtmlItem = items.any((item) => item.type == 'text/html');
      if (hasUriItem && hasHtmlItem && !hasTextItem) {
        createGhost(event);
        event.dataTransfer!.dropEffect = 'copy';
      }
    }

    if (event.dataTransfer!.types!.indexOf('Files') >= 0) {
      if (event.dataTransfer!.items!.length == 1 &&
          event.dataTransfer!.items![0].type.indexOf('image') > -1) {
        event.preventDefault();
        createGhost(event);
        event.dataTransfer!.dropEffect = 'copy';
      }
    } else {
      event.stopPropagation();
      event.dataTransfer!.dropEffect = 'none';
    }
  }

  void dragleaveHandler(html.MouseEvent event) {
    return hideGhost();
  }

  Future<void> dropHandler(html.MouseEvent event) async {
    event.preventDefault();
    dynamic dropAnchor = this.dropAnchor;
    hideGhost();

    if (event.dataTransfer!.items!.isNotEmpty) {
      for (html.DataTransferItem item in event.dataTransfer!.items!) {
        if (item.kind == 'string' && item.type == 'text/uri-list') {
          item.getAsString((String str) async {
            // TODO: Implement the logic for URL_REG and IMAGE_EXT_REG
            // You may need to create separate variables for these and replace them with the actual values below.
            if (URL_REG.hasMatch(str) && dropAnchor != null) {
              bool isImage = false;
              if (IMAGE_EXT_REG.hasMatch(str)) {
                isImage = true;
              }
              if (!isImage) {
                // TODO: Implement the logic for checkImageContentType
                // You may need to create a separate method for this and replace it with the actual method name below.
                isImage = await checkImageContentType(str);
              }
              if (!isImage) return;

              String text = '![]($str)';
              // TODO: Implement the logic for createBlockP, insertBefore, and insertAfter
              // You may need to create separate methods for these and replace them with the actual method names below.
              dynamic imageBlock = createBlockP(text);
              if (dropAnchor['position'] == 'up') {
                insertBefore(imageBlock, dropAnchor['anchor']);
              } else {
                insertAfter(imageBlock, dropAnchor['anchor']);
              }

              String key = imageBlock.children[0].key;
              int offset = 0;
              // TODO: Implement the logic for updating the cursor
              // You may need to create a separate method for this and replace it with the actual method name below.
              updateCursor(key: key, offset: offset);
              // TODO: Implement the logic for rendering the content
              render();

              // TODO: Implement the logic for dispatching the stateChange event
              muya.eventCenter.dispatch('stateChange');
            }
          });
        }
      }
    }

    if (event.dataTransfer!.files != null) {
      List<File> fileList = [];
      for (html.File file in event.dataTransfer!.files!) {
        fileList.add(File(file.name));
      }
      File? image = fileList.firstWhere((file) => file.type.startsWith('image'),
          orElse: () => null);
      if (image != null && dropAnchor != null) {
        String name = image.name;
        String path = image.path;
        String id = 'loading-${getUniqueId()}';
        String text = '![${id}](${path})';
        // TODO: Implement the logic for createBlockP, insertBefore, and insertAfter
        // You may need to create separate methods for these and replace them with the actual method names below.
        dynamic imageBlock = createBlockP(text);
        if (dropAnchor['position'] == 'up') {
          insertBefore(imageBlock, dropAnchor['anchor']);
        } else {
          insertAfter(imageBlock, dropAnchor['anchor']);
        }

        String key = imageBlock.children[0].key;
        int offset = 0;
        // TODO: Implement the logic for updating the cursor
        // You may need to create a separate method for this and replace
        // it with the actual method name below.
        updateCursor(key: key, offset: offset);
        // TODO: Implement the logic for rendering the content
        render();

        try {
          // TODO: Implement the logic for handling the imageAction
          // You may need to create a separate method for this and replace it with the actual method name below.
          String newSrc = await muya.options.imageAction(path, id, name);
          // TODO: Implement the logic for getImageSrc
          // You may need to create a separate method for this and replace it with the actual method name below.
          dynamic src = getImageSrc(path);
          if (src != null) {
            // TODO: Implement the logic for updating the urlMap
            // You may need to create a separate method for this and replace it with the actual method name below.
            stateRender.urlMap.set(newSrc, src);
          }
          // TODO: Implement the logic for finding the imageWrapper
          // You may need to create a separate method for this and replace it with the actual method name below.
          html.Element? imageWrapper =
              muya.container.querySelector('span[data-id=$id]');

          if (imageWrapper != null) {
            // TODO: Implement the logic for getImageInfo
            // You may need to create a separate method for this and replace it with the actual method name below.
            dynamic imageInfo = getImageInfo(imageWrapper);
            // TODO: Implement the logic for replaceImage
            // You may need to create a separate method for this and replace it with the actual method name below.
            replaceImage(imageInfo, {'alt': name, 'src': newSrc});
          }
        } catch (error) {
          // TODO: Notify the user about an error.
          print('Unexpected error on image action: $error');
        }
        // TODO: Implement the logic for dispatching the stateChange event
        muya.eventCenter.dispatch('stateChange');
      }
    }
  }
}
