// ignore_for_file: prefer_const_constructors
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:morningbrew/db/todo_database.dart';
import 'package:morningbrew/widgets/add_todo.dart';
import 'package:morningbrew/widgets/edit_page.dart';
import 'package:morningbrew/widgets/models.dart';
import 'package:morningbrew/widgets/to_do_list.dart';
import 'package:morningbrew/widgets/todo_listview.dart';

class ItemWidget extends StatefulWidget {
  State<StatefulWidget> createState() => _ItemWidget();
}

class _ItemWidget extends State<ItemWidget> {
  late List<Item> _items;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  void dispose() {
    TodoDatabase.instance.close();

    super.dispose();
  }

  Future refresh() async {
    setState(() => isLoading = true);

    this._items = await TodoDatabase.instance.readAllItems();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Add(),
            ),
          ).then(
            (value) => refresh(),
          );
        },
        child: Icon(Icons.add),
      ),
      body: isLoading
          ? LinearProgressIndicator()
          : _items.isEmpty
              ? Bubble(
                  color: Color(0xff43CC47),
                  margin: BubbleEdges.only(top: 5),
                  child: Text(
                    'Looks like you are free today',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                )
              : StaggeredGridView.countBuilder(
                  itemCount: _items.length,
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  crossAxisCount: 1,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return GestureDetector(
                        onTap: () async {
                          await Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (context) => EditPage(
                                    itemId: item.id as int,
                                  ),
                                ),
                              )
                              .then(
                                (value) => refresh(),
                              );
                        },
                        child: ListviewWidget(item: item, index: index));
                  },
                ),
    );
  }
}
