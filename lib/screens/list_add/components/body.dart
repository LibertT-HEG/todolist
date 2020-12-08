import 'package:flutter/material.dart';
import 'package:todolist/screens/list_add/components/field_titre.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20,20,20,20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FieldTitre(),
          ],
        ));
  }
}
