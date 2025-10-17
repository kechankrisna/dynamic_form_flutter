import 'package:dynamic_form_plus/dynamic_form_plus.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'test_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => MyHomePage(),
          '/test_form': (context) => TestForm(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var facebookIconJson = null;
  List<Map<String, dynamic>> iconsJson = [];
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Test Dynamic Form"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/test_form');
              },
              child: const Text("Test Form"),
            ),
            TextButton(
                onPressed: () {
                  // var facebook = Icon(Icons.facebook, color: Colors.blue);
                  // var result = IconSerializer.toJson(facebook);
                  // print(result);

                  // print("==================");

                  // setState(() {
                  //   facebookIconJson = result;
                  // });
                  var icons = [
                    Icon(Icons.facebook, color: Colors.blue),
                    Icon(Icons.link, color: Colors.blue),
                    Icon(Icons.telegram, color: Colors.green),
                    Icon(MdiIcons.instagram, color: Colors.blue),
                    Icon(MdiIcons.twitter, color: Colors.blue),
                  ];
                  List<Map<String, dynamic>> _results = [];
                  for (var icon in icons) {
                    var result = IconSerializer.toJson(icon);
                    _results.add(result);
                    print("result ========> $result");
                  }
                  setState(() {
                    iconsJson = _results;
                  });
                },
                child: Wrap(
                  children: [
                    ...iconsJson.map((e) => IconSerializer.fromJson(e)).toList(),
                    if(facebookIconJson != null) IconSerializer.fromJson(facebookIconJson),
                    IconSerializer.fromJson({
                      "type": "Icon",
                      "icon": {
                        "codePoint": 57941,
                        "fontFamily": "MaterialIcons",
                        "fontPackage": null,
                        "matchTextDirection": false,
                        "fontFamilyFallback": null
                      }
                    }),
                    Text("convert"),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
