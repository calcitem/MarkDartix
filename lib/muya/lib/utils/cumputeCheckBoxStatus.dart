import 'package:flutter/material.dart';

class ParentCheckbox extends StatefulWidget {
  @override
  _ParentCheckboxState createState() => _ParentCheckboxState();
}

class _ParentCheckboxState extends State<ParentCheckbox> {
  bool parentCheckboxValue = false;
  List<bool> childrenCheckboxValues = [false, false, false];

  void _updateParentCheckbox() {
    setState(() {
      parentCheckboxValue = childrenCheckboxValues.every((checked) => checked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Checkbox(
          value: parentCheckboxValue,
          onChanged: (bool? value) {
            setState(() {
              parentCheckboxValue = value!;
              childrenCheckboxValues =
                  List.filled(childrenCheckboxValues.length, value);
            });
          },
        ),
        Column(
          children: childrenCheckboxValues
              .asMap()
              .entries
              .map(
                (entry) => Checkbox(
                  value: entry.value,
                  onChanged: (bool? value) {
                    setState(() {
                      childrenCheckboxValues[entry.key] = value!;
                    });
                    _updateParentCheckbox();
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
