import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:your_project/utils.dart'; // Import the file containing the deepCopy function

const int UNDO_DEPTH = 100; // Replace with the value from your config

class History {
  List<dynamic> stack = [];
  int index = -1;
  dynamic contentState; // Replace with the type of your ContentState class
  dynamic pending; // Replace with the type of your pending state

  History(this.contentState);

  void undo() {
    commitPending();
    if (index > 0) {
      index = index - 1;

      Map<String, dynamic> state = deepCopy(stack[index]);
      Map<String, dynamic> blocks = state['blocks'];
      Map<String, dynamic> cursor = state['cursor'];
      Map<String, dynamic> renderRange = state['renderRange'];
      cursor['noHistory'] = true;
      contentState.blocks = blocks;
      contentState.renderRange = renderRange;
      contentState.cursor = cursor;
      contentState.render();
    }
  }

  void redo() {
    pending = null;
    int len = stack.length;
    if (index < len - 1) {
      index = index + 1;
      Map<String, dynamic> state = deepCopy(stack[index]);
      Map<String, dynamic> blocks = state['blocks'];
      Map<String, dynamic> cursor = state['cursor'];
      Map<String, dynamic> renderRange = state['renderRange'];
      cursor['noHistory'] = true;
      contentState.blocks = blocks;
      contentState.renderRange = renderRange;
      contentState.cursor = cursor;
      contentState.render();
    }
  }

  void push(Map<String, dynamic> state) {
    pending = null;
    stack = List.from(stack.sublist(0, index + 1));
    Map<String, dynamic> copyState = deepCopy(state);
    stack.add(copyState);
    if (stack.length > UNDO_DEPTH) {
      stack.removeAt(0);
      index = index - 1;
    }
    index = index + 1;
  }

  void pushPending(Map<String, dynamic> state) {
    pending = state;
  }

  void commitPending() {
    if (pending != null) {
      push(pending);
    }
  }

  void clearHistory() {
    stack = [];
    index = -1;
    pending = null;
  }
}
