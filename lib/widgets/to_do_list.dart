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
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 7),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Scaffold(
          floatingActionButton: FloatingActionButton.small(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
          body: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage(
                        'images/PinClipart.com_coffee-pot-clip-art_2896273.png'),
                    height: 35,
                    width: 35,
                  ),
                  Bubble(
                    nipWidth: 5,
                    nipHeight: 5,
                    alignment: Alignment.topLeft,
                    margin: BubbleEdges.only(top: 5),
                    nipOffset: 4,
                    child: Text(
                      'Things to get done today',
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                    color: Color(0xff1982FC),
                    nip: BubbleNip.leftBottom,
                  ),
                ],
              ),
              //add to do list logic here
            ],
          ),
        ),
      ),
    );
  }
}
