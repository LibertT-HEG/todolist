import 'package:cloud_firestore/cloud_firestore.dart';

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
}
