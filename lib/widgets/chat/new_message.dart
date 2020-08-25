import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/model/prayer_comment.dart';
import 'package:flutter_firebase_chat_app/service/auth_service.dart';
import 'package:flutter_firebase_chat_app/service/database_service.dart';
import 'package:provider/provider.dart';

enum InputType {
  CHAT,
  PRAYER_COMMENT,
}

class UserInput extends StatefulWidget {
  final InputType type;
  final docId;

  UserInput.chat({this.docId}) : this.type = InputType.CHAT;

  UserInput.comment({@required this.docId})
      : this.type = InputType.PRAYER_COMMENT;

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  DatabaseService _dbService;
  AuthService _authService;

  var _enteredMessage = '';
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      _dbService = Provider.of<DatabaseService>(context, listen: false);
      _authService = Provider.of<AuthService>(context, listen: false);
    });
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    var user = await _authService.user;
    switch (widget.type) {
      case InputType.CHAT:
        _dbService.insertChatMessage(user.uid, _enteredMessage);
        break;
      case InputType.PRAYER_COMMENT:
        _dbService.insertNewPrayerComment(
            user.uid, widget.docId, PrayerComment(comment: _enteredMessage));
        break;
    }
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
              decoration: InputDecoration(
                  labelText: widget.type == InputType.CHAT
                      ? 'Send a message...'
                      : 'Comment'),
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
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
