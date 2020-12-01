import 'package:flutter/material.dart';

class TempNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ElevatedButton(
            child: Text('List view'),
            onPressed: () {
              Navigator.pushNamed(context, "/ListView");
            },
          ),
        ),
        Spacer(flex: 1),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            child: Text('About'),
            onPressed: () {
              Navigator.pushNamed(context, "/About");
            },
          ),
        )
      ],
    );
  }
}
