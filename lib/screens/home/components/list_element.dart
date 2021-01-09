import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListElement extends StatefulWidget {
  String listId;
  String listName;
  DateTime listDeadLine;

  ListElement({
    this.listId,
    this.listName,
    this.listDeadLine,
  });

  @override
  State<StatefulWidget> createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 10),
        color: Colors.grey.withAlpha(10),
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.pushNamed(context, "/ListView",
                  arguments: widget.listId);
            },
            child: Column(children: <Widget>[
              ListTile(
                title: Text(widget.listName),
                subtitle: Text('Dead line: ' +
                    DateFormat('dd MMMM yy à kk:mm')
                        .format(widget.listDeadLine)),
              )
            ])));
  }
}
