import 'package:flutter/material.dart';
import 'package:todolist/screens/list_view/components/body.dart';

class ListViewScreen extends StatefulWidget {
  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste XYZ'),
      ),
      body: Body(),
    );
  }
}
