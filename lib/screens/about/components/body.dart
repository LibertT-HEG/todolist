import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Row(
        children: <Widget>[
          new Container(
            child: new Image.asset('assets/images/logo.png', height: 200.0,),
          ),
          new Container(
            child: new Text('long information text'),
          ),
        ],
      )
    );
  }
}
