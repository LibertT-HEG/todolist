import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/list_add/components/MyCustomForm.dart';

class ListAddScreen extends StatefulWidget {
  @override
  _ListAddScreenState createState() => _ListAddScreenState();
}

class _ListAddScreenState extends State<ListAddScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
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
            title: Text('Ajouter une liste'),
          ),
          body: MyCustomForm(),

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

class Todo {
  String title;
  DateTime dLine;
  List<String> tags;
  DocumentReference documentReference;

  Todo(String title, DateTime dLine) {
    this.title = title;
    this.dLine = dLine;
    this.tags = [];
    this.documentReference = null;
  }

  add_tags(String tag) {
    this.tags.add(tag);
  }
}
