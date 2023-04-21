import 'dart:html';
import 'package:muya/muya.dart';

class DragDrop {
  Muya muya;

  DragDrop(Muya muya) {
    this.muya = muya;
    dragStartBinding();
    dragOverBinding();
    dropBinding();
    dragEndBinding();
  }

  void dragStartBinding() {
    final container = muya.container;
    final eventCenter = muya.eventCenter;

    void dragStartHandler(Event event) {
      if ((event.target as Element).tagName == 'IMG') {
        event.preventDefault();
      }
    }

    eventCenter.attachDOMEvent(container, 'dragstart', dragStartHandler);
  }

  void dragOverBinding() {
    final container = muya.container;
    final eventCenter = muya.eventCenter;
    final contentState = muya.contentState;

    void dragoverHandler(Event event) {
      contentState.dragoverHandler(event);
    }

    eventCenter.attachDOMEvent(container, 'dragover', dragoverHandler);
  }

  void dropBinding() {
    final container = muya.container;
    final eventCenter = muya.eventCenter;
    final contentState = muya.contentState;

    void dropHandler(Event event) {
      contentState.dropHandler(event);
    }

    eventCenter.attachDOMEvent(container, 'drop', dropHandler);
  }

  void dragEndBinding() {
    final eventCenter = muya.eventCenter;
    final contentState = muya.contentState;

    void dragleaveHandler(Event event) {
      contentState.dragleaveHandler(event);
    }

    eventCenter.attachDOMEvent(window, 'dragleave', dragleaveHandler);
  }
}
