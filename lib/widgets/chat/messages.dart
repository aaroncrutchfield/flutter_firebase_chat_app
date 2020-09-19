import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/model/firebase/collections/chat.dart';
import 'package:flutter_firebase_chat_app/service/auth_service.dart';
import 'package:flutter_firebase_chat_app/service/database_service.dart';
import 'package:flutter_firebase_chat_app/widgets/chat/message_bubble.dart';
import 'package:provider/provider.dart';

class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _dbService = Provider.of<DatabaseService>(context, listen: false);
    final _authService = Provider.of<AuthService>(context, listen: false);

    
    return FutureBuilder(
      future: _authService.user,
      builder: (ctx, authUser) {
        print('hasData: ${authUser.hasData}');
        print(authUser.connectionState);
        if (authUser.hasError) print(authUser.error);
        if (authUser.connectionState == ConnectionState.waiting || !authUser.hasData) {
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
                  isMe: chatDocs[index].userId == authUser.data.uid,
                  key: ValueKey(chatDocs[index].id),
                ),
              );
            });
      },
    );
  }
}
