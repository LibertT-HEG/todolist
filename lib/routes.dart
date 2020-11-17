import 'package:flutter/widgets.dart';
import 'package:todolist/screens/home.dart';
// import 'package:todolist/screens/about.dart';
// import 'package:todolist/screens/list_add.dart';
// import 'package:todolist/screens/list_details.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => MyHomePage(),
};
