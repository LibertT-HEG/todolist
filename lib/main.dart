import 'package:flutter/material.dart';
import 'package:todolist/routes.dart';
import 'package:todolist/theme/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToutDoux Liste',
      theme: appTheme(),
      initialRoute: '/',
      routes: routes,
    );
  }
}
