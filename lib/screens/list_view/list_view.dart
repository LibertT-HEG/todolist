import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todolist/screens/list_view/components/body.dart';

class ListViewScreen extends StatefulWidget {
  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final String listId = ModalRoute.of(context).settings.arguments;

    CollectionReference taches = FirebaseFirestore.instance
        .collection('Listes')
        .doc(listId)
        .collection("Taches");
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
              title: Text('Liste'),
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
                    );
                  }).toList(),
                );
              },
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
