import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'databaseexample/DatabaseProvider.dart';
import 'databaseexample/model/ToDoListItem.dart';

class DatabaseExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DatabaseStatefulWidget(),
    );
  }
}

class DatabaseStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DatabaseState();
  }
}

class DatabaseState extends State<DatabaseStatefulWidget> {
  int _nextid = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite DB Example"),
      ),
      body: FutureBuilder<List<ToDoListItem>>(
          future: DatabaseProvider.db.fetchAllToDoItems(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ToDoListItem>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  ToDoListItem item = snapshot.data[index];
                  return ListTile(
                    title: Text(item.item),
                    trailing: Checkbox(
                        value: item.isDone, onChanged: (bool value) {}),
                  );
                },
                itemCount: snapshot.data.length,
              );
            } else {
              return Center(child: Text("Click on + to add items: $_nextid"));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DatabaseProvider.db.insertToDoItem(
              ToDoListItem(id: _nextid, item: "Item-$_nextid", isDone: true));
          setState(() {
            _nextid = _nextid + 1;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
