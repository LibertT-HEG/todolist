import 'package:flutter/material.dart';

class BodyLandscape extends StatelessWidget {
  // Style petit text
  double fsPetitText = 15;
  FontWeight fwPetitText = FontWeight.w300;

  //Style grand texte
  double fsGrandText = 20;
  FontWeight fwGrandText = FontWeight.bold;

  @override
  Widget build(BuildContext context) {
    // Propriété de l'écran
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(left: widthScreen/4, top: heightScreen/8),
      child: new Row(
        children: <Widget>[
          Container(
              child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(20),
                    child: new Image.asset('assets/images/logo.png', height: 150.0))
          ])),
          Container(
              child: Column(children: [
                Container(
                  child: Text("ToutDoux Liste",
                      style: TextStyle(
                          fontSize: fsGrandText,
                          fontWeight: fwGrandText,
                          height: 4)),
            ),
                Center(
                  child: Text("Version 0.1.1",
                      style: TextStyle(
                      fontSize: fsPetitText, fontWeight: fwPetitText)),
            ),
                Center(
                  child: Text('© 2020-2021 ToutDouxListe Inc.',
                      style: TextStyle(
                      fontSize: fsPetitText, fontWeight: fwPetitText, height: 4)),
            ),
          ]))
        ],
      ),
    );
  }
}
