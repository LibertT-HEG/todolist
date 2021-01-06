import 'package:flutter/material.dart';

class BodyLandscape extends StatelessWidget {
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
                    child: new Image.asset(urlStr, height: 150.0))
          ])),
          Container(
              child: Column(children: [
                Container(
                  child: Text(grandTexte,
                      style: TextStyle(
                          fontSize: fsGrandText,
                          fontWeight: fwGrandText,
                          height: 4)),
            ),
                Center(
                  child: Text(version,
                      style: TextStyle(
                      fontSize: fsPetitText, fontWeight: fwPetitText)),
            ),
                Center(
                  child: Text(copyright,
                      style: TextStyle(
                      fontSize: fsPetitText, fontWeight: fwPetitText, height: 4)),
            ),
          ]))
        ],
      ),
    );
  }
}
