// ignore_for_file: prefer_const_constructors

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

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    this.item = await TodoDatabase.instance.readItem(widget.itemId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [deleteItem()],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(12),
              child: Text(item.title),
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
}
