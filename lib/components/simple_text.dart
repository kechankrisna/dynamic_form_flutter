import 'package:flutter/material.dart';

import '../functions.dart';
import '../utils/input_decoration_serializer.dart';

class SimpleText extends StatefulWidget {
  const SimpleText({
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
  _SimpleText createState() => _SimpleText();
}

class _SimpleText extends State<SimpleText> {
  dynamic item;

  String? isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['key']] ?? 'Please enter some text';
    }
    return null;
  }

  // Helper method to get InputDecoration from various sources
  InputDecoration _getInputDecoration() {
    // Priority: item['decoration'] -> widget.decorations[item['key']] -> default

    // First check if item['decoration'] exists and is valid
    if (item['decoration'] != null) {
      if (item['decoration'] is InputDecoration) {
        // Already an InputDecoration object
        return item['decoration'];
      } else if (item['decoration'] is Map<String, dynamic>) {
        // JSON object, deserialize it
        try {
          return InputDecorationSerializer.fromJson(item['decoration']);
        } catch (e) {
          // If deserialization fails, fall through to next option
          print('Error deserializing decoration: $e');
        }
      } else if (item['decoration'] is String) {
        // JSON string, deserialize it
        try {
          return InputDecorationSerializer.fromJsonString(item['decoration']);
        } catch (e) {
          // If deserialization fails, fall through to next option
          print('Error deserializing decoration string: $e');
        }
      }
    }

    // Check widget.decorations[item['key']]
    if (widget.decorations.containsKey(item['key']) &&
        widget.decorations[item['key']] != null) {
      return widget.decorations[item['key']];
    }

    // Default decoration
    return InputDecoration(
      hintText: item['placeholder'] ?? "",
      helperText: item['helpText'] ?? "",
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    Widget label = SizedBox.shrink();
    if (Fun.labelHidden(item)) {
      label = Container(
        child: Text(
          item['label'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      );
    }
    final bool isTextArea = item['type'] == "TextArea";
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          label,
          TextFormField(
            controller: null,
            initialValue: item['value'] ?? null,
            decoration: _getInputDecoration(),
            maxLines: isTextArea ? 10 : 1,
            onChanged: (String value) {
              item['value'] = value;
              // _handleChanged();
              //  print(value);
              widget.onChange(widget.position, value);
            },
            obscureText: item['type'] == "Password" ? true : false,
            keyboardType: item['keyboardType'] ??
                widget.keyboardTypes[item['key']] ??
                (isTextArea ? TextInputType.multiline : TextInputType.text),
            validator: (value) {
              if (widget.validations.containsKey(item['key'])) {
                return widget.validations[item['key']](item, value);
              }
              if (item.containsKey('validator')) {
                if (item['validator'] != null) {
                  if (item['validator'] is Function) {
                    return item['validator'](item, value);
                  }
                }
              }
              if (item['type'] == "Email") {
                return Fun.validateEmail(item, value!);
              }

              if (item.containsKey('required')) {
                if (item['required'] == true ||
                    item['required'] == 'True' ||
                    item['required'] == 'true') {
                  return isRequired(item, value);
                }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
