import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  // Style petit text
  double fsPetitText = 15;
  FontWeight fwPetitText = FontWeight.w300;

  //Style grand texte
  double fsGrandText = 20;
  FontWeight fwGrandText = FontWeight.bold;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: new Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(height: 200),
              Center(
                child: Text("ToutDoux Liste", style: TextStyle(fontSize: fsGrandText, fontWeight: fwGrandText, height: 2)),
              ),
              Center(
                child: Text("Version 0.1.1", style: TextStyle(fontSize: fsPetitText, fontWeight: fwPetitText)),
              ),
              Center(
                child: Column(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: new Image.asset('assets/images/logo.png', height: 150.0)
                  )
                ])
              ),
              Center(
                child: Text('© 2020-2021 ToutDouxListe Inc.', style: TextStyle( fontSize: fsPetitText, fontWeight: fwPetitText)),
              ),
            ],
          ),
        )
    );
  }
}
