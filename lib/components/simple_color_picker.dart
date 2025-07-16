import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../functions.dart';
import '../utils/input_decoration_serializer.dart';

class SimpleColorPicker extends StatefulWidget {
  const SimpleColorPicker({
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
  _SimpleColorPicker createState() => _SimpleColorPicker();
}

class _SimpleColorPicker extends State<SimpleColorPicker> {
  dynamic item;
  late TextEditingController textController;

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
    textController = TextEditingController(text: item['value']);
  }

  // Helper function to convert hex string to Color
  Color hexToColor(String hex) {
    return Color(int.parse(hex.replaceAll('#', '0xFF')));
  }

  // Helper function to convert Color to hex string
  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
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
      prefixIcon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: hexToColor(item['value'] ?? "#25a970"),
        ),
        width: 34,
        height: 34,
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
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
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          label,
          TextFormField(
            onTap: () {
              // Open color picker dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select Color'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: item['value'] != null
                            ? hexToColor(item['value'])
                            : hexToColor("#25a970"),
                        onColorChanged: (Color color) {
                          setState(() {
                            item['value'] = colorToHex(color);
                          });
                          widget.onChange(widget.position, colorToHex(color));
                          setState(() {
                            textController.text = item['value'] ?? '';
                          });
                        },
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            controller: textController,
            // initialValue: item['value'] ?? null,
            decoration: _getInputDecoration(),
            
            maxLines: item['type'] == "TextArea" ? 10 : 1,
            onChanged: (String value) {
              item['value'] = value;
              // _handleChanged();
              //  print(value);
              widget.onChange(widget.position, value);
            },
            obscureText: item['type'] == "Password" ? true : false,
            keyboardType: item['keyboardType'] ??
                widget.keyboardTypes[item['key']] ??
                TextInputType.text,
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
