import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/screens/list_add/components/addList.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  String titre;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference listes = FirebaseFirestore.instance.collection('Listes');

    Future<void> addList() {
      // Call the lists CollectionReference to add a new list
      return listes
          .add({
        'titre': this.titre
      })
          .then((value) => print("List Added"))
          .catchError((error) => print("Failed to add list: $error"));
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          controller: myController,
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Example: Trip to LA',
            labelText: 'Titre *',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the
        // text that the user has entered into the text field.
        onPressed: () {
          this.titre = this.myController.text;
          return addList();
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.done_rounded, color: Color(0xFFFFFFFF)),
      ),
    );

  }
}

