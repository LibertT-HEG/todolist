import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/classes/task.dart';

class ListViewScreen extends StatefulWidget {
  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _formKey = GlobalKey<FormState>();
  Task _task = new Task(null);

  Widget _taskForm(currentValue) {
    return TextFormField(
      initialValue: currentValue != null ? currentValue : '',
      decoration: InputDecoration(labelText: "Nom de la tâche"),
      validator: (String value) {
        if (value.isEmpty) {
          return "requis";
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

    Future<void> deleteTask(taskId) {
      // Call the Taches CollectionReference to add a new tache
      return taches.doc(taskId).delete();
    }

    Future<bool> editTaskDialog(currentValue) async {
      return showDialog<bool>(
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
                        Navigator.of(context).pop(false);
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
                        _taskForm(currentValue),
                        RaisedButton(
                          child: Text("Modifier"),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              Navigator.of(context).pop(true);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    }

    Future<bool> confirmDelete() async {
      return showDialog<bool>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Supprimer la liste'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Êtes-vous sûr-e de vouloir supprimer la liste ?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text('Supprimer'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );
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
          actions: [
            FutureBuilder(
                future: listes.doc(args).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  // Check for errors
                  if (snapshot.hasError) {
                    return Text('Error');
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    return IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        confirmDelete().then((confirmed) => {
                              if (confirmed)
                                {
                                  listes.doc(snapshot.data.id).delete(),
                                  Navigator.pop(context)
                                }
                            });
                      },
                    );
                  }

                  return Text('Please wait');
                }),
            FutureBuilder(
                future: listes.doc(args).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  // Check for errors
                  if (snapshot.hasError) {
                    return Text('Error');
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    return IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        confirmDelete().then((confirmed) => {
                              if (confirmed)
                                {
                                  listes.doc(snapshot.data.id).delete(),
                                  Navigator.pop(context)
                                }
                            });
                      },
                    );
                  }

                  return Text('Please wait');
                })
          ]),
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
              return Row(children: [
                Expanded(
                    child: GestureDetector(
                        onLongPress: () {
                          editTaskDialog(document.data()['nom'])
                              .then((confirmed) => {
                                    if (confirmed)
                                      {
                                        setState(() {
                                          taches
                                              .doc(document.id)
                                              .update({'nom': _task.nom});
                                        })
                                      }
                                  });
                        },
                        child: CheckboxListTile(
                          title: Text(document.data()['nom']),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: document.data()['fait'],
                          onChanged: (bool value) {
                            setState(() {
                              taches.doc(document.id).update({'fait': value});
                            });
                          },
                          activeColor: Colors.green,
                        ))),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteTask(document.id);
                    })
              ]);
            }).toList());
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
                            _taskForm(null),
                            RaisedButton(
                              child: Text("Ajouter"),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  addTask();
                                  Navigator.pop(context);
                                  return;
                                }
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
