import 'package:flutter/material.dart';

class AddListButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, "/ListAdd");
      },
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Colors.green,
    );
  }
}
