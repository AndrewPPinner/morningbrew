// ignore_for_file: unnecessary_this, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:morningbrew/widgets/models.dart';

class ListviewWidget extends StatelessWidget {
  const ListviewWidget({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final Item item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Bubble(
      nipWidth: 5,
      nipHeight: 5,
      alignment: Alignment.topLeft,
      margin: BubbleEdges.only(top: 5),
      nipOffset: 4,
      child: Text(
        item.title,
        style: TextStyle(fontSize: 11, color: Colors.white),
      ),
      color: Color(0xff1982FC),
      nip: BubbleNip.leftBottom,
    );
  }
}
