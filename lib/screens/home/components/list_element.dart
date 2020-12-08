import 'package:flutter/material.dart';

class ListElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 5),
        color: Colors.blueAccent,
        child: Row(
          children: [Text("To do list")],
        ));
  }
}
