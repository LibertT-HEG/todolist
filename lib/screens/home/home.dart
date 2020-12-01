import 'package:flutter/material.dart';
import 'package:todolist/screens/home/components/body.dart';
import 'package:todolist/screens/home/components/add_list_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: Body(),
      floatingActionButton: AddListButton(),
    );
  }
}
