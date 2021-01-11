import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:todolist/classes/todo.dart';

class ListElement extends StatefulWidget {
  Todo todo = new Todo();

  ListElement({this.todo});

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
              Navigator.pushNamed(context, "/ListView", arguments: widget.todo);
            },
            child: Column(children: <Widget>[
              ListTile(
                  title: Text(
                    widget.todo.title,
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text('Dead line: ' +
                                DateFormat('dd MMMM yy à kk:mm')
                                    .format(widget.todo.dLine) +
                                '\n')),
                        Tags(
                          itemCount: widget.todo.tags.length,
                          itemBuilder: (int index) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: ItemTags(
                                  key: Key(index.toString()),
                                  index: index,
                                  title: widget.todo.tags[index],
                                  pressEnabled: false,
                                ));
                          },
                        ),
                      ])),
            ])));
  }
}
