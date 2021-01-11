import 'package:flutter/material.dart';
import 'package:todolist/routes.dart';
import 'package:todolist/theme/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = "fr_FR";
  initializeDateFormatting();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            // TODO: une nouvelle page d'error
            title: 'ToutDoux Liste',
            theme: appTheme(),
            initialRoute: '/',
            routes: routes,
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'ToutDoux Liste',
            theme: appTheme(),
            initialRoute: '/',
            routes: routes,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          // TODO: une nouvelle loading page
          title: 'ToutDoux Liste',
          theme: appTheme(),
          initialRoute: '/',
          routes: routes,
        );
      },
    );
  }
}
