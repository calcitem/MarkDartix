import 'package:flutter/material.dart';

class ContentState {
  GlobalKey<EditableTextState>? editableTextKey;
  TextSelection? selectedImage;
  dynamic selectedTableCells;

  ContentState({this.editableTextKey});

  void docDeleteHandler() {
    // Handle `delete` keydown event on document.

    // Handle delete selected image
    if (selectedImage != null) {
      selectedImage = null;
      // Call the method to delete the image
      // deleteImage(selectedImage);
    }
    if (selectedTableCells != null) {
      // Call the method to delete selected table cells
      // deleteSelectedTableCells();
    }
  }

  void deleteHandler() {
    TextSelection? selection = editableTextKey!.currentState!.selection;
    if (selection == null) {
      return;
    }
    TextPosition start = selection.start;
    TextPosition end = selection.end;

    // TODO: Implement the logic for startBlock, nextBlock, etc.
    // You will need to define these variables and their types based on your use case.
    // For example, you may use a custom class to represent a block in your implementation.

    // startBlock, nextBlock, type, text, key are not defined in this example.

    // Only handle h1~h6 span block
    if (type.contains('span') && start.offset == 0 && text[1] == '\n') {
      // event.preventDefault();
      startBlock.text = text.substring(2);
      // Update the cursor with the new position
      // this.cursor = {
      //   start: { key, offset: 0 },
      //   end: { key, offset: 0 }
      // };
      // singleRender(startBlock);
    }
    if (type.contains(RegExp(r'h\d|span')) && start.offset == text.length) {
      // event.preventDefault();
      if (nextBlock != null && nextBlock.type.contains(RegExp(r'h\d|span'))) {
        // if cursor at the end of code block-language input, do nothing!
        if (nextBlock.functionType == 'codeContent' &&
            startBlock.functionType == 'languageInput') {
          return;
        }

        startBlock.text += nextBlock.text;

        List<dynamic> toBeRemoved = [nextBlock];

        dynamic parent = getParent(nextBlock);
        dynamic target = nextBlock;

        while (isOnlyRemoveableChild(target)) {
          toBeRemoved.add(parent);
          target = parent;
          parent = getParent(parent);
        }

        toBeRemoved.forEach((b) {
          removeBlock(b);
        });

        int offset = start.offset;
        // Update the cursor with the new position
        // this.cursor = {
        //   start: { key, offset },
        //   end: { key, offset }
        // };
        // render();
      }
    }
  }

  // TODO: Implement the methods for getParent, isOnlyRemoveableChild, and removeBlock based on your use case.
  // For example, you may use a custom class to represent a block in your implementation.
  dynamic getParent(dynamic block) {
    // Implement your logic here
  }

  bool isOnlyRemoveableChild(dynamic target) {
    // Implement your logic here
    return false;
  }

  void removeBlock(dynamic block) {
    // Implement your logic here
  }
}
