import 'package:flutter/material.dart';

import 'widgets/widget_b.dart';
import 'package:example/widgets/widget_a.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Column(
        children: [
          WidgetA(),
          WidgetB(),
        ],
      ),
    );
  }
}
