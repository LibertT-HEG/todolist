import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/screens/list_add/list_add.dart';
import 'package:todolist/screens/list_view/list_view.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  String listId;
  String nom;
  DateTime deadLine;

  MyCustomForm({
    this.listId,
    this.nom,
    this.deadLine,
  });

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  DateTime dateTemp = DateTime.now();

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
    DocumentReference documentReference = listes.doc();

    Future<void> addList(MyCustomForm argum) {
      // Call the lists CollectionReference to add a new list


      return documentReference.set({
        'nom': argum.nom,
        'deadLine' : argum.deadLine,
      })
          .then((value) => print("List Added"))
          .catchError((error) => print("Failed to add list: $error"));
        'nom': this.todo.title,
        'deadLine': this.todo.dLine,
      });
      // .then((value) => print("List Added"))
      // .catchError((error) => print("Failed to add list: $error"));
    }

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: myController,
            decoration: const InputDecoration(
              hintText: 'Exemple: Voyage à LA',
              labelText: 'Titre *',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DateTimeField(
              decoration: const InputDecoration(
                labelText: 'Deadline',
              ),
              onDateSelected: (DateTime value) {
                setState(() {
                  dateTemp = value;
                });
              },
              firstDate: DateTime.now(),
              selectedDate: dateTemp,
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
      ]),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the
        // text that the user has entered into the text field.
        onPressed: () {


          MyCustomForm argum = new MyCustomForm(
              listId: documentReference.id,
              nom: this.myController.text,
              deadLine: dateTemp);

          addList().then((value) => {
                Navigator.popAndPushNamed(context, "/ListView",
                    arguments: argum.listId)
              });
        },
        tooltip: 'Ajouter',
        child: Icon(Icons.done_rounded, color: Color(0xFFFFFFFF)),
      ),
    );
  }
}
