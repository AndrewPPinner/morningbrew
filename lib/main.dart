// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:morningbrew/widgets/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morning Brew',
      home: HomePage(),
    );
  }
}
