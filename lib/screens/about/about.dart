import 'package:flutter/material.dart';
import 'package:todolist/screens/about/components/body.dart';
import 'package:todolist/screens/about/components/bodyLandscape.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A propos'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation){
          if(orientation == Orientation.portrait){
            return Body();
          } else {
            return BodyLandscape();
          }
        },
      ),
    );
  }
}
