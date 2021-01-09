import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/home/components/add_list_button.dart';
import 'package:todolist/screens/home/components/list_element.dart';
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

          return StreamBuilder<QuerySnapshot>(
              stream: listes.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                List<ListElement> listes =
                    snapshot.data.docs.map((DocumentSnapshot document) {
                  return new ListElement(
                      listId: document.id,
                      listName: document.data()['nom'],
                      listDeadLine: document.data()['deadLine'].toDate());
                }).toList();

                return Scaffold(
                    appBar: AppBar(
                        title: Text('Mes todo listes'),
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.info),
                            onPressed: () {
                              Navigator.pushNamed(context, "/About");
                            },
                          )
                        ]),
                    floatingActionButton: AddListButton(),
                    backgroundColor: Colors.grey.shade300,
                    body: ListView(
                        padding: const EdgeInsets.all(15),
                        children: [Column(children: listes)]));
              });
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
