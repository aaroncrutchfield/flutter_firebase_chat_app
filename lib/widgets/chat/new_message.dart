import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/service/auth_service.dart';
import 'package:flutter_firebase_chat_app/service/database_service.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  DatabaseService _dbService;
  AuthService _authService;

  var _enteredMessage = '';
  final _controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero)
        .then((_) {
          _dbService = context.read<DatabaseService>();
          _authService = context.read<AuthService>();
        });
  }

  void _sendMessage() async {
  	FocusScope.of(context).unfocus();
    var userData = await _authService.userData;
  	  _dbService.insertChatMessage(userData, Timestamp.now(), _enteredMessage);

  	_controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
	            controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (messageInput) {
                setState(() {
                  _enteredMessage = messageInput;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage
            ,
          )
        ],
      ),
    );
  }
}
