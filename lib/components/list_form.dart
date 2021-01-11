import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/classes/todo.dart';

// Define a custom Form widget.
class ListAddForm extends StatefulWidget {
  Todo todo = new Todo();

  ListAddForm({this.todo});

  @override
  _ListAddFormState createState() => _ListAddFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _ListAddFormState extends State<ListAddForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final listTitleInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final listTagsInput = TextEditingController();
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
      if (widget.todo.documentReference == null) {
        DocumentReference documentReference = listes.doc();
        widget.todo.documentReference = documentReference;
      }

      widget.todo.documentId = widget.todo.documentReference.id;

      return widget.todo.documentReference.set({
        'nom': widget.todo.title,
        'deadLine': widget.todo.dLine,
        'tags': widget.todo.tags
      });
    }

    var title = (widget.todo.documentReference == null)
        ? "Nouvelle liste"
        : "Modifier la liste";

    this.listTitleInput.text = widget.todo.title;
    this.listTagsInput.text = widget.todo.tags.join(",");

    return AlertDialog(
        title: Text(title),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            // TASK TITLE
            Padding(
              padding: const EdgeInsets.all(5.0),
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
            // TASK DEADLINE
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: DateTimeField(
                decoration: const InputDecoration(
                  labelText: 'Dead line',
                ),
                onDateSelected: (DateTime value) {
                  setState(() {
                    widget.todo.dLine = value;
                  });
                },
                firstDate: DateTime.now(),
                selectedDate: widget.todo.dLine,
              ),
            ),
            // TASK TAGS
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                controller: listTagsInput,
                decoration: const InputDecoration(
                  hintText: 'Ex: Ecole, Important, A faire...',
                  labelText: 'Tags',
                ),
              ),
            )
          ])),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                widget.todo.title = this.listTitleInput.text;
                if (this.listTagsInput.text.length > 0) {
                  widget.todo.tags = this
                      .listTagsInput
                      .text
                      .split(',')
                      .map((tag) => tag.trim())
                      .where((tag) => tag.length > 0)
                      .toList();
                }
                if (widget.todo.documentReference == null) {
                  addList().then((value) => {
                        Navigator.popAndPushNamed(context, "/ListView",
                            arguments: widget.todo)
                      });
                } else {
                  addList().then(
                      (value) => {Navigator.of(context).pop(widget.todo)});
                }
              }
            },
            child: Text("Valider"),
          )
        ]);
  }
}
