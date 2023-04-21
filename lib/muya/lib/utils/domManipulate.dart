import 'package:flutter/widgets.dart';

void operateClassName(Element element, String ctrl, String className) {
  if (ctrl == 'add') {
    element.classes.add(className);
  } else if (ctrl == 'remove') {
    element.classes.remove(className);
  } else {
    throw ArgumentError('Invalid control argument: $ctrl');
  }
}

void insertBefore(RenderObject newNode, RenderObject originNode) {
  final RenderObject parentNode = originNode.parent;
  parentNode.insert(newNode, before: originNode);
}

void insertAfter(RenderObject newNode, RenderObject originNode) {
  final RenderObject parentNode = originNode.parent;

  if (originNode.nextSibling != null) {
    parentNode.insert(newNode, after: originNode);
  } else {
    parentNode.add(newNode);
  }
}
