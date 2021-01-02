import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todolist/screens/list_add/list_add.dart';

class TaskAddScreen extends StatefulWidget {
  final Todo todo;
  TaskAddScreen({Key key, @required this.todo}) : super(key: key);
  @override
  _TaskAddScreenState createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(widget.todo.dLine.toString()),
      ),
    );
  }


}