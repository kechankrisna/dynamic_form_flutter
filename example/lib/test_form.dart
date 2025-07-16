import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dynamic_form/json_schema.dart';

class TestForm extends StatefulWidget {
  const TestForm({Key? key}) : super(key: key);

  @override
  State<TestForm> createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  String form = json.encode({
    'title': 'Test Form Json Schema',
    'description': 'my description',
    'fields': [
      {
        "key": "name",
        "type": "Input",
        "label": "Name",
        "placeholder": "Please enter the name",
        "value": "Meow Station",
        "required": true,
        "decoration": {
          "labelText": "Name",
          "hintText": "Please enter the name",
          "prefixIcon": {
            "type": "Icon",
            "icon": {
              "codePoint": 57941,
              "fontFamily": "MaterialIcons",
            },
            "size": 28.0,
            "color": 4280391411,
          },
        }
      },
      {
        "key": "description",
        "type": "TextArea",
        "label": "Description",
        "placeholder": "Please enter the description",
        "value": "",
        "required": false,
        
      },
      {
        "key": "image_url",
        "type": "Input",
        "label": "Image URL",
        "placeholder": "Please enter the image URL",
        "value": "",
        "required": false
      },
      {
        "key": "facebook_link",
        "type": "Input",
        "label": "Facebook Link",
        "placeholder": "Please enter the Facebook link",
        "value": "https://www.facebook.com/mylekhaapp",
        "required": false,
        "decoration": {
          "labelText": "Description",
          "hintText": "Please enter the description",
          "prefixIcon": {
            "type": "Icon",
            "icon": {
              "codePoint": 57522,
              "fontFamily": "MaterialIcons",
            },
            "size": 28.0,
            "color": 4280391411,
          },
        }
      },
      {
        "key": "instagram_link",
        "type": "Input",
        "label": "Instagram Link",
        "placeholder": "Please enter the Instagram link",
        "value": "",
        "required": false
      },
      {
        "key": "twitter_link",
        "type": "Input",
        "label": "Twitter Link",
        "placeholder": "Please enter the Twitter link",
        "value": "",
        "required": false
      },
      {
        "key": "youtube_link",
        "type": "Input",
        "label": "YouTube Link",
        "placeholder": "Please enter the YouTube link",
        "value": "https://www.youtube.com/mylekha",
        "required": false
      },
      {
        "key": "linkedin_link",
        "type": "Input",
        "label": "LinkedIn Link",
        "placeholder": "Please enter the LinkedIn link",
        "value": "",
        "required": false
      },
      {
        "key": "tiktok_link",
        "type": "Input",
        "label": "TikTok Link",
        "placeholder": "Please enter the TikTok link",
        "value": "https://tiktok.com",
        "required": false
      },
      {
        "key": "phone_links",
        "type": "TareaText",
        "label": "Phone Links",
        "placeholder": "Please enter phone links (one per line)",
        "value": "tel:010233222",
        "required": false
      },
      {
        "key": "telegram_link",
        "type": "Input",
        "label": "Telegram Link",
        "placeholder": "Please enter the Telegram link",
        "value": "http://t.me/Mylekha",
        "required": false
      },
      {
        "key": "website_link",
        "type": "Input",
        "label": "Website Link",
        "placeholder": "Please enter the website link",
        "value": "https://mylekha.net",
        "required": false
      },
      {
        "key": "slides",
        "type": "Group",
        "label": "Slides URLs",
        "placeholder": "Please enter slide URLs (one per line)",
        "required": false,
        "value": [
          {
            "type": "Input",
            "label": "Slide 1",
            "value":
                "https://pub-5b951138628a4a14b4b00952a4aade68.r2.dev/images/slide_1.png",
          },
          {
            "type": "Input",
            "label": "Slide 2",
            "value":
                "https://pub-5b951138628a4a14b4b00952a4aade68.r2.dev/images/slide_2.png",
          },
          {
            "type": "Input",
            "label": "Slide 3",
            "value":
                "https://pub-5b951138628a4a14b4b00952a4aade68.r2.dev/images/slide_3.png",
          }
        ]
      },
      {
        "key": "background_image_url",
        "type": "Input",
        "label": "Background Image URL",
        "placeholder": "Please enter the background image URL",
        "value":
            "https://pub-5b951138628a4a14b4b00952a4aade68.r2.dev/images/dining.jpg",
        "required": false
      },
      {
        "key": "custom_css",
        "type": "TareaText",
        "label": "Custom CSS",
        "placeholder": "Please enter custom CSS",
        "value": "",
        "required": false
      },
      {
        "key": "no_image_url",
        "type": "Input",
        "label": "No Image URL",
        "placeholder": "Please enter the no-image URL",
        "value":
            "https://pub-5b951138628a4a14b4b00952a4aade68.r2.dev/images/no-image.jpg",
        "required": false,
      },
      {
        "key": "enable_order",
        "type": "Switch",
        "label": "Enable Order",
        "switchValue": true,
        "required": false
      },
      {
        "key": "primary_color",
        "type": "ColorPicker",
        "label": "Primary Color",
        "placeholder": "Please enter the primary color (hex code)",
        "value": "#25a970",
        "required": false,
      }
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Test Form with Map"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            JsonSchema(
              form: form,
              onChanged: (dynamic response) {
                print(jsonEncode(response));
              },
              actionSave: (data) {
                // print(jsonEncode(data));
                var value = jsonDecode(jsonEncode(data));
                var fields = value['fields'];
                print(fields);
                print('-----------------');
                var expectValue = Map<String, dynamic>();
                for (var field in fields) {
                  // print('${field['key']}: ${field['value']}');
                  final key = field['key'].toString();
                  final value = field['value'];
                  if (value is List) {
                    var nestedValue = [];
                    for (var i = 0; i < value.length; i++) {
                      final itemKey = value[i]['key'];
                      final itemValue = value[i]['value'] ?? '';
                      if (itemKey == null) {
                        nestedValue.add(itemValue);
                      } else {
                        nestedValue.add({'key': itemKey, 'value': itemValue});
                      }
                    }
                    expectValue[key] = nestedValue;
                  } else {
                    expectValue[key] = value;
                  }
                }
                print(expectValue);
              },
              autovalidateMode: AutovalidateMode.always,
              buttonSave: Container(
                height: 40.0,
                color: Colors.blueAccent,
                child: const Center(
                  child: Text("Send",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
