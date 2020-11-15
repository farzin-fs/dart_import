import 'package:flutter/material.dart';

import 'package:example/utils.dart' as utils;

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        utils.sayHello("Joe"),
      ),
    );
  }
}
