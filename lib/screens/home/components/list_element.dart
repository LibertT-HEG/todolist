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
    return new GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/ListView", arguments: listId);
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.all(5),
            color: Colors.blueAccent,
            child: Column(
              children: [
                Text(this.listName == null ? "LISTNAME" : this.listName),
                Text(this.listDeadLine == null
                    ? "LISTDEADLINE"
                    : 'Deadline: ' +
                        DateFormat('yyyy-MM-dd – kk:mm')
                            .format(this.listDeadLine)),
              ],
            )));
  }
}
