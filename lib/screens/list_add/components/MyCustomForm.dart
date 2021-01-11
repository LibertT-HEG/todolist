import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/screens/list_add/list_add.dart';
import 'package:todolist/screens/list_view/list_view.dart';

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
  final listTitleInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final listTagsInput = TextEditingController();
  Todo todo = new Todo("test", DateTime.now());

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    listTitleInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference listes =
        FirebaseFirestore.instance.collection('Listes');

    Future<void> addList() {
      // Call the lists CollectionReference to add a new list
      DocumentReference documentReference = listes.doc();
      this.todo.documentReference = documentReference;
      return documentReference.set({
        'nom': this.todo.title,
        'deadLine': this.todo.dLine,
        'tags': this.todo.tags
      });
      // .then((value) => print("List Added"))
      // .catchError((error) => print("Failed to add list: $error"));
    }

    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: listTitleInput,
                decoration: const InputDecoration(
                  hintText: 'Exemple: Voyage à LA',
                  labelText: 'Titre *',
                ),
                validator: (String value) {
                  return value == null ? 'Requis' : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DateTimeField(
                decoration: const InputDecoration(
                  labelText: 'Dead line',
                ),
                onDateSelected: (DateTime value) {
                  setState(() {
                    this.todo.dLine = value;
                  });
                },
                firstDate: DateTime.now(),
                selectedDate: this.todo.dLine,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: listTagsInput,
                decoration: const InputDecoration(
                  hintText: 'Ex: Ecole, Important, A faire...',
                  labelText: 'Tags',
                ),
              ),
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the
        // text that the user has entered into the text field.
        onPressed: () {
          if (_formKey.currentState.validate()) {
            this.todo.title = this.listTitleInput.text;
            if (this.listTagsInput.text.length > 0) {
              this.todo.tags = this.listTagsInput.text.split(',');
            }
            addList().then((value) => {
                  Navigator.popAndPushNamed(context, "/ListView",
                      arguments: this.todo.documentReference.id)
                });
          }
        },
        tooltip: 'Ajouter',
        child: Icon(Icons.done_rounded, color: Color(0xFFFFFFFF)),
      ),
    );
  }
}
