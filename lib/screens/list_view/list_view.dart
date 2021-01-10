import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListViewScreen extends StatefulWidget {
  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _formKey = GlobalKey<FormState>();
  Task _task = new Task(null);

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Nom de la tâche"),
      validator: (String value) {
        if (value.isEmpty) {
          return "required";
        }
        return null;
      },
      onSaved: (String value) {
        _task.nom = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;

    CollectionReference taches = FirebaseFirestore.instance
        .collection('Listes')
        .doc(args)
        .collection("Taches");

    CollectionReference listes =
        FirebaseFirestore.instance.collection('Listes');

    Future<void> addTask() {
      // Call the Taches CollectionReference to add a new tache
      return taches
          .add({'nom': _task.nom, 'fait': _task.fait})
          .then((value) => print("Task Added"))
          .catchError((error) => print("Failed to add Task: $error"));
    }

    taches.snapshots(includeMetadataChanges: true);
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
            future: listes.doc(args).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                return Text('Error');
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();
                return Text('${data['nom']}');
              }

              return Text('Please wait');
            }),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: taches.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          }),
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
                            RaisedButton(
                              child: Text("Ajouter"),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  print(_task.nom);
                                  print(args);
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
        child: Icon(
          Icons.add,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}

class Task {
  String nom;
  bool fait;

  Task(String nom) {
    this.nom = nom;
    this.fait = false;
  }
}
