import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/screens/auth_screen.dart';
import 'package:flutter_firebase_chat_app/screens/tab_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 51, 51, 51),
        primarySwatch: Colors.purple,
        backgroundColor: Colors.deepPurple,
        accentColor: Colors.amber,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.white
          ),
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFeatures: [FontFeature.enable('smcp')],
            fontSize: 18,
          ),
          headline2: TextStyle(
            color: Colors.amber,
            fontFeatures: [FontFeature.enable('smcp')],
            fontSize: 14,
          ),
        ),
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.purple,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return TabScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
