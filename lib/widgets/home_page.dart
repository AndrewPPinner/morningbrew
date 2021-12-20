// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningbrew/main.dart';
import 'package:morningbrew/widgets/coffee.dart';
import 'package:morningbrew/widgets/data_service.dart';
import 'package:morningbrew/widgets/pref_service.dart';
import 'package:morningbrew/widgets/settings.dart';
import 'package:morningbrew/widgets/stock.dart';
import 'package:morningbrew/widgets/to_do_list.dart';
import 'package:morningbrew/widgets/weather.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Stock();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemH = (size.height - kToolbarHeight - 24) / 2;
    final double itemW = size.width / 2;

    return Scaffold(
      backgroundColor: Color(0xff34CBB9),
      appBar: AppBar(
        backgroundColor: const Color(0xff34CBB9),
        title: const Center(
          child: Text('Morning Brew'),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: SizedBox(
              child: GridView.count(
                childAspectRatio: (itemW / itemH),
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  Todo(),
                  weather(),
                  Coffee(),
                  Stock(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
