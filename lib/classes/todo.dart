import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String documentId;
  String title;
  DateTime dLine;
  List<dynamic> tags;
  DocumentReference documentReference;

  Todo() {
    this.title = "";
    this.dLine = DateTime.now();
    this.tags = [];
    this.documentReference = null;
  }
}
