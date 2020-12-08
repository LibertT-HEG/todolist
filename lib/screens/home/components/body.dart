import 'package:flutter/material.dart';
import 'package:todolist/screens/home/components/list_element.dart';
import 'package:todolist/screens/home/components/temp_nav.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listes = <Widget>[];

    listes.add(new TempNav());

    for (var i = 0; i < 15; i++) {
      listes.add(new ListElement());
    }

    return new ListView(padding: const EdgeInsets.all(15), children: listes);
  }
}
