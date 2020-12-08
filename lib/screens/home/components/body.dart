import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        ElevatedButton(
          child: Text('List view'),
          onPressed: () {
            Navigator.pushNamed(context, "/ListView");
          },
        ),
        ElevatedButton(
          child: Text('About'),
          onPressed: () {
            Navigator.pushNamed(context, "/About");
          },
        ),
      ],
    ));
  }
}
