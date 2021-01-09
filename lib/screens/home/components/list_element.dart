import 'package:flutter/material.dart';

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
            height: 80,
            margin: const EdgeInsets.only(bottom: 5),
            color: Colors.blueAccent,
            child: Row(
              children: [Text(this.listName)],
            )));
  }
}
