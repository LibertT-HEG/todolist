import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tags/flutter_tags.dart';

class ListElement extends StatefulWidget {
  String listId;
  String listName;
  DateTime listDeadLine;
  List<dynamic> listTags;

  ListElement({this.listId, this.listName, this.listDeadLine, this.listTags});

  @override
  State<StatefulWidget> createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.pushNamed(context, "/ListView",
                  arguments: widget.listId);
            },
            child: Column(children: <Widget>[
              ListTile(
                  title: Text(
                    widget.listName,
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text('Dead line: ' +
                                DateFormat('dd MMMM yy à kk:mm')
                                    .format(widget.listDeadLine) +
                                '\n')),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Tags(
                              itemCount: widget.listTags.length,
                              itemBuilder: (int index) {
                                return ItemTags(
                                  key: Key(index.toString()),
                                  index: index,
                                  title: widget.listTags[index],
                                  pressEnabled: false,
                                );
                              },
                            )),
                      ])),
            ])));
  }
}
