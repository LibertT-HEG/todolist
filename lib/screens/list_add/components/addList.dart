import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddList extends StatelessWidget {
  final String titre;

  AddList(this.titre);

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
    return FlatButton(
      onPressed: addList,
      child: Text(
        "Add List",
      ),
    );
  }
}