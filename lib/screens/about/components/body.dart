import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: new Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Center(
                child: Text("ToutDoux Liste", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Center(
                child: Text("Version 0.1", style: TextStyle(fontSize: 18, )),
              ),
              Center(
                child: new Image.asset('assets/images/logo.png', height: 200.0,),
              ),
              Center(
                child: Text('ToutDoux Liste est application de prise de note \n\n Version 0.1', textAlign: TextAlign.center,),
              ),
            ],
          ),
        )
    );
  }
}
