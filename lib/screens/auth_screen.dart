import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_chat_app/model/user_data.dart';
import 'package:flutter_firebase_chat_app/service/auth_service.dart';
import 'package:flutter_firebase_chat_app/service/database_service.dart';
import 'package:flutter_firebase_chat_app/service/storage_service.dart';
import 'package:flutter_firebase_chat_app/widgets/auth/auth_form.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthService _authService;
  DatabaseService _databaseService;
  StorageService _storageService;
  var _isLoading = false;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero)
        .then((_) {
      _authService = Provider.of<AuthService>(context, listen: false);
      _databaseService = Provider.of<DatabaseService>(context, listen: false);
      _storageService = Provider.of<StorageService>(context, listen: false);
    });
  }

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      setState(() => _isLoading = true);
      if (isLogin) {
        authResult = await _authService.signInWithEmailAndPassword(email, password);
      } else {
        authResult = await _authService.registerWithEmailAndPassword(
            email, password);

        final url = await _storageService.uploadUserImage(authResult.user.uid, image);

        await _databaseService.insertNewUserData(UserData(
          id: authResult.user.uid,
          email: email,
          imageUrl: url,
          username: username,
        ));

      }
    } on PlatformException catch (error) {
      var message = 'An error occurred, please check your credentials';

      if (error.message != null) {
        message = error.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() => _isLoading = false);
    } catch (error) {
      print(error);
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
