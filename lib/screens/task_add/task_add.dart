import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todolist/screens/list_add/list_add.dart';
import 'package:todolist/screens/list_view/list_view.dart';

import 'components/list_task.dart';

class TaskAddScreen extends StatefulWidget {
  final Todo todo;
  TaskAddScreen({Key key, @required this.todo}) : super(key: key);
  @override
  _TaskAddScreenState createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {

  final _formKey = GlobalKey<FormState>();

  Task _task = new Task(null, DateTime.now());





  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nom de la tâche"
      ),
      validator: (String value){
        if(value.isEmpty){
          return "required";
        }
        return null;
      },
      onSaved: (String value) {
        _task.nom = value;
      },
    );
  }

  /*Widget _buildDline() {
    return DateTimeField(
      decoration: const InputDecoration(
        labelText: 'Deadline',
      ),
      onDateSelected: (DateTime value) {
        setState(() {
          _task.deadLine = value;
        });
      },
      firstDate: DateTime.now(),
      selectedDate: _task.deadLine,
    );
  }*/

  Widget _buildDeadLine() {
    return DateTimeFormField(
      initialValue: DateTime.now(),
      decoration: const InputDecoration(
        labelText: 'Deadline',
      ),
      onDateSelected: (DateTime value) {
        setState(() {
          _task.deadLine = value;
        });
      },
      firstDate: DateTime.now(),
      onSaved: (DateTime value) {
        _task.deadLine = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference liste = FirebaseFirestore.instance.collection('Listes').doc(widget.todo.documentReference.id).collection("Taches");

    Future<void> addTask() {
      // Call the user's CollectionReference to add a new user
      return liste
          .add({
        'nom': _task.nom, // John Doe
        'deadLine': _task.deadLine, // Stokes and Sons
        'fait': _task.fait // 42
      })
          .then((value) => print("Task Added"))
          .catchError((error) => print("Failed to add Task: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo.title),
      ),
      body: Center(
        child: TaskListScreen(todo: widget.todo),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              _buildName(),
                              _buildDeadLine(),
                              //_buildDline(),
                              RaisedButton(
                                child: Text("Ajouter"),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    print(_task.nom);
                                    print(_task.deadLine);
                                    print(widget.todo.documentReference);
                                    addTask();
                                    Navigator.pop(context);
                                    return;
                                  }
                                  //print(_task.deadLine);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Icon(Icons.add, color: Color(0xFFFFFFFF),),
        ),
    );
  }
}
