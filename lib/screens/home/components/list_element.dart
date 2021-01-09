import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListElement extends StatelessWidget {
  final String listId;
  final String listName;
  final DateTime listDeadLine;

  const ListElement({
    this.listId,
    this.listName,
    this.listDeadLine,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 10),
        color: Colors.grey.withAlpha(10),
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.pushNamed(context, "/ListView", arguments: listId);
            },
            child: Column(children: <Widget>[
              ListTile(
                title: Text(this.listName == null ? "LISTNAME" : this.listName),
                subtitle: Text(this.listDeadLine == null
                    ? "LISTDEADLINE"
                    : 'Deadline: ' +
                        DateFormat('yyyy-MM-dd – kk:mm')
                            .format(this.listDeadLine)),
              )
            ])));
  }
}
