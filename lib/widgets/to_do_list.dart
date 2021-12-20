// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:bubble/bubble.dart';
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
      padding: EdgeInsets.only(top: 10, left: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage(
                      'images/PinClipart.com_coffee-pot-clip-art_2896273.png'),
                  height: 40,
                  width: 40,
                ),
                Bubble(
                  nipWidth: 5,
                  nipHeight: 5,
                  margin: BubbleEdges.only(top: 10),
                  alignment: Alignment.topCenter,
                  child: Text(
                    'List of things to do today',
                    style: TextStyle(fontSize: 11.65),
                  ),
                  color: Color(0xff1982FC),
                  nip: BubbleNip.leftTop,
                ),
              ],
            ),
            //add to do list logic here
          ],
        ),
      ),
    );
  }
}
