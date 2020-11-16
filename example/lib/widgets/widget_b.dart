import 'package:example/helpers/helpers.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        sayHello(helperB),
      ),
    );
  }
}
