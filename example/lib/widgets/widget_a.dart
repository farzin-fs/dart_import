import 'package:example/helpers/helper_a.dart';
import 'package:flutter/material.dart';

import 'package:example/utils.dart' as utils;

class WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        utils.sayHello(helperA),
      ),
    );
  }
}
