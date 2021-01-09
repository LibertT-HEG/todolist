import 'package:flutter/material.dart';
import 'package:todolist/screens/home/components/add_list_button.dart';
import 'package:todolist/screens/home/components/list_element.dart';
import 'package:todolist/screens/home/components/temp_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    CollectionReference listes =
        FirebaseFirestore.instance.collection('Listes');

    listes.snapshots(includeMetadataChanges: true);

    final listElements = <Widget>[];

    listElements.add(new TempNav());

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
              title: Text('My todo lists'),
            ),
            floatingActionButton: AddListButton(),
            body: StreamBuilder<QuerySnapshot>(
              stream: listes.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                for (var i = 0; i < 15; i++) {
                  listElements.add(new ListElement(
                      listId: i.toString(),
                      listName: "To do liste " + i.toString(),
                      listDeadLine: DateTime
                          .now())); // TODO: Mettre la date de la dead line
                }

                return new ListView(
                    padding: const EdgeInsets.all(15),
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return new ListElement(
                          listId: document.data()['num'],
                          listName: document.data()['nom'],
                          listDeadLine: DateTime.now());
                    }).toList());
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
