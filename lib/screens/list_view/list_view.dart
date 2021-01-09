import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/screens/list_add/list_add.dart';
import 'package:todolist/screens/task_add/task_add.dart';

class ListViewScreen extends StatefulWidget {

  final Todo todo; //merge
  ListViewScreen({Key key, @required this.todo}) : super(key: key); //merge


  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
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

    CollectionReference taches = FirebaseFirestore.instance
        .collection('Listes')
        .doc("1g2aoT5qPaZ2NVnuakGZ")
        .collection("Taches");

    Future<void> addTask() {
      // Call the user's CollectionReference to add a new user
      return taches
          .add({
        'nom': _task.nom, // John Doe
        'deadLine': _task.deadLine, // Stokes and Sons
        'fait': _task.fait // 42
      })
          .then((value) => print("Task Added"))
          .catchError((error) => print("Failed to add Task: $error"));
    }

    taches.snapshots(includeMetadataChanges: true);
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Text('Error'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.todo.title),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: taches.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new CheckboxListTile(
                      title: Text(document.data()['nom']),
                      subtitle: new Text('Deadline: ' +
                          DateFormat('yyyy-MM-dd – kk:mm')
                              .format(document.data()['deadLine'].toDate())),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: document.data()['fait'],
                      onChanged: (bool value) {
                        setState(() {
                          taches.doc(document.id).update({'fait': value});
                        });
                      },
                      activeColor: Colors.green,

                    );
                  }).toList(),
                );
              },
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
                                        //print(widget.todo.documentReference);
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
        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          appBar: AppBar(
            title: Text('Please wait'),
          ),
          body: Text('Please wait'),
        );
      },
    );
  }
}

class Task {
  String nom;
  DateTime deadLine;
  bool fait;

  Task(String nom, DateTime deadLine){
    this.nom = nom;
    this.deadLine = deadLine;
    this.fait = false;
  }
}
