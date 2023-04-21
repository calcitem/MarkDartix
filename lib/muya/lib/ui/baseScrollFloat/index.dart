import 'package:flutter/material.dart';

abstract class BaseScrollFloat extends StatefulWidget {
  final Function(dynamic) onSelect;

  BaseScrollFloat({required this.onSelect});

  @override
  BaseScrollFloatState createState() => BaseScrollFloatState();
}

class BaseScrollFloatState extends State<BaseScrollFloat> {
  int _activeIndex = 0;
  List<dynamic> _items = [];

  void setActiveIndex(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  void setItems(List<dynamic> items) {
    setState(() {
      _items = items;
    });
  }

  void step(bool isNext) {
    int newIndex = isNext ? _activeIndex + 1 : _activeIndex - 1;
    if (newIndex < 0 || newIndex >= _items.length) {
      return;
    }
    setActiveIndex(newIndex);
  }

  void selectItem(dynamic item) {
    widget.onSelect(item);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _items[index];
        return buildItem(context, item, index == _activeIndex);
      },
    );
  }

  Widget buildItem(BuildContext context, dynamic item, bool isActive);
}
