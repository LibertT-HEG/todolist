import 'package:flutter/widgets.dart';
import 'package:todolist/screens/home/home.dart';
import 'package:todolist/screens/about/about.dart';
import 'package:todolist/screens/list_view/list_view.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/ListView": (BuildContext context) => ListViewScreen(),
  "/About": (BuildContext context) => AboutScreen(),
};
