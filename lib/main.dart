import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/screens/auth_screen.dart';
import 'package:flutter_firebase_chat_app/screens/tab_screen.dart';
import 'package:flutter_firebase_chat_app/service/auth_service.dart';
import 'package:flutter_firebase_chat_app/service/storage_service.dart';
import 'package:provider/provider.dart';

import 'service/database_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseService>(create: (_) => DatabaseService()),
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<StorageService>(create: (_) => StorageService()),
      ],
      child: MaterialApp(
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
              fontSize: 18,
            ),
            headline3: TextStyle(
              color: Colors.amber,
              fontFeatures: [FontFeature.enable('smcp')],
              fontSize: 12,
            ),
            headline5: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFeatures: [FontFeature.enable('smcp')],
              fontSize: 18,
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
      ),
    );
  }
}
