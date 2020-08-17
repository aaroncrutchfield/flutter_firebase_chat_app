import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/data/database_service.dart';
import 'package:flutter_firebase_chat_app/model/chat.dart';
import 'package:flutter_firebase_chat_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  DatabaseService _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dbService.getCurrentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: _dbService.getChatList(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting ||
                  !chatSnapshot.hasData) return Text('');
              final List<Chat> chatDocs = chatSnapshot.data;
              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  message: chatDocs[index].message,
                  userName: chatDocs[index].username,
                  userImage: chatDocs[index].userImage,
                  isMe: chatDocs[index].userId == futureSnapshot.data.uid,
                  key: ValueKey(chatDocs[index].id),
                ),
              );
            });
      },
    );
  }
}
