// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningbrew/db/todo_database.dart';
import 'package:morningbrew/widgets/models.dart';

class EditPage extends StatefulWidget {
  final int itemId;

  const EditPage({
    Key? key,
    required this.itemId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPage();
}

class _EditPage extends State<EditPage> {
  late Item item;
  bool isLoading = false;
  bool edit = false;
  final editController = TextEditingController();
  late FocusNode focus;

  @override
  void initState() {
    refresh();
    super.initState();
    focus = FocusNode();
  }

  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    this.item = await TodoDatabase.instance.readItem(widget.itemId);

    setState(() {
      isLoading = false;
      editController.text = item.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            edit = false;
          });
          editItem();
          Navigator.pop(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: editButton(),
        actions: [deleteItem()],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(12),
              child: TextField(
                focusNode: focus,
                controller: editController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: edit,
                ),
              ),
            ),
    );
  }

  Widget deleteItem() {
    return IconButton(
      onPressed: () async {
        await TodoDatabase.instance.delete(widget.itemId);
        Navigator.pop(context);
      },
      icon: Icon(Icons.delete),
    );
  }

  Widget editButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          edit = true;
        });
        Timer(Duration(milliseconds: 20), () {
          focus.requestFocus();
        });
      },
      icon: Icon(Icons.edit),
    );
  }

  Future editItem() async {
    final updatedItem = Item(id: widget.itemId, title: editController.text);
    await TodoDatabase.instance.update(updatedItem);
  }
}
