import 'package:flutter/widgets.dart';
import 'package:todolist/screens/home/home.dart';
import 'package:todolist/screens/about/about.dart';
import 'package:todolist/screens/list_view/list_view.dart';
import 'package:todolist/screens/list_add/list_add.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/ListAdd": (BuildContext context) => ListAddScreen(),
  "/ListView": (BuildContext context) => ListViewScreen(),
  "/About": (BuildContext context) => AboutScreen(),
};
