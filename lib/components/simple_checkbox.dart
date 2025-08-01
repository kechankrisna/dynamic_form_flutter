import 'package:flutter/material.dart';

import '../functions.dart';

class SimpleListCheckbox extends StatefulWidget {
  const SimpleListCheckbox({
    Key? key,
    required this.item,
    required this.onChange,
    required this.position,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.keyboardTypes = const {},
  }) : super(key: key);
  final dynamic item;
  final Function onChange;
  final int position;
  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;

  @override
  _SimpleListCheckbox createState() => _SimpleListCheckbox();
}

class _SimpleListCheckbox extends State<SimpleListCheckbox> {
  dynamic item;
  List<dynamic> selectItems = [];

  String? isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['key']] ?? 'Please enter some text';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    item = widget.item;
    for (var i = 0; i < item['items'].length; i++) {
      if (item['items'][i]['value'] == true) {
        selectItems.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> checkboxes = [];
    if (Fun.labelHidden(item)) {
      checkboxes.add(Text(item['label'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)));
    }
    for (var i = 0; i < item['items'].length; i++) {
      checkboxes.add(
        Row(
          children: <Widget>[
            Expanded(child: Text(item['items'][i]['label'])),
            Checkbox(
              value: item['items'][i]['value'],
              onChanged: (bool? value) {
                this.setState(
                  () {
                    item['items'][i]['value'] = value;
                    if (value!) {
                      selectItems.add(i);
                    } else {
                      selectItems.remove(i);
                    }
                    widget.onChange(widget.position, selectItems);
                    //_handleChanged();
                  },
                );
              },
            ),
          ],
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: checkboxes,
      ),
    );
  }
}
