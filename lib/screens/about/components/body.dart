import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  // Image
  String urlStr = 'assets/images/logo.png';

  // Style petit text
  double fsPetitText = 15;
  FontWeight fwPetitText = FontWeight.w300;
  String version = "Version 0.1.1";
  String copyright = '© 2020-' + DateTime.now().year.toString() + ' ToutDouxListe Inc.';

  //Style grand texte
  double fsGrandText = 20;
  FontWeight fwGrandText = FontWeight.bold;
  String grandTexte = "ToutDouxListe";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: new Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(height: 200),
              Center(
                child: Text(grandTexte, style: TextStyle(fontSize: fsGrandText, fontWeight: fwGrandText, height: 2)),
              ),
              Center(
                child: Text(version, style: TextStyle(fontSize: fsPetitText, fontWeight: fwPetitText)),
              ),
              Center(
                child: Column(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: new Image.asset(urlStr, height: 150.0)
                  )
                ])
              ),
              Center(
                child: Text(copyright, style: TextStyle( fontSize: fsPetitText, fontWeight: fwPetitText)),
              ),
            ],
          ),
        )
    );
  }
}
