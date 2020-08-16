import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/widgets/chat/messages.dart';
import 'package:flutter_firebase_chat_app/widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final firebaseMessaging = FirebaseMessaging();
    firebaseMessaging.requestNotificationPermissions();
    firebaseMessaging.configure(
      onMessage: (msg) {
        print('onMessage: $msg');
        return;
      },
      onLaunch: (msg) {
        print('onLaunch: $msg');
        return;
      },
      onResume: (msg) {
        print('onResume: $msg');
        return;
      },
    );

    firebaseMessaging.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(child: Messages()),
          NewMessage(),
        ],
      ),
    );
  }
}
