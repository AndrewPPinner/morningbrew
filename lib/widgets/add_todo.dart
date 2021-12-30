// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_this

import 'package:flutter/material.dart';
import 'package:morningbrew/db/todo_database.dart';
import 'package:morningbrew/widgets/models.dart';

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addState();
}

class _addState extends State<Add> {
  @override
  void initState() {
    super.initState();
  }

  final addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              addItem();
              Navigator.pop(context);
            },
            child: Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              maxLines: null,
              controller: addController,
              decoration: InputDecoration(
                hintText: 'Add to To-Do List',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future addItem() async {
    final item = Item(title: addController.text);
    await TodoDatabase.instance.create(item);
  }
}
