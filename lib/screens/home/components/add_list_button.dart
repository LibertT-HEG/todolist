import 'package:flutter/material.dart';
import 'package:todolist/components/list_form.dart';

class AddListButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        return showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return ListAddForm(todo: null);
            });
      },
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Colors.green,
    );
  }
}
