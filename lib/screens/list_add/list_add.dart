import 'package:flutter/material.dart';
import 'package:todolist/screens/list_add/components/body.dart';

class ListAddScreen extends StatefulWidget {
  @override
  _ListAddScreenState createState() => _ListAddScreenState();
}

class _ListAddScreenState extends State<ListAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une liste'),
      ),
      body: Body(),
    );
  }
}
