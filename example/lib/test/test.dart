import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:example/widgets/widget_a.dart';
import 'package:example/utils.dart';
import 'package:example/widgets/widget_b.dart';

part 'part.dart';

import 'package:example/main.dart';
import 'package:example/widgets/widget_a.dart';
import 'package:example/helpers/helper_b.dart';
import 'package:example/helpers/helper_a.dart';


import 'dart:async';

class Test extends StatelessWidget {
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
