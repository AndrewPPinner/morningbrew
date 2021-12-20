import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _todostate();
}

class _todostate extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [],
      ),
    );
  }
}
