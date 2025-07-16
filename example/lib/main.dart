import 'package:dynamic_form/dynamic_form.dart';
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
                  var child = Icon(Icons.attach_money, color: Colors.blue);
                  var result = IconSerializer.toJson(child);
                  print(result);
                },
                child: Wrap(
                  children: [
                    Icon(Icons.attach_money, color: Colors.blue),
                    IconSerializer.fromJson({
                      "type": "Icon",
                      "icon": {
                        "codePoint": 57941,
                        "fontFamily": "MaterialIcons",
                      },
                      "size": 20.0,
                      "color": 4280391411,
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
