import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/model/prayer_comment.dart';
import 'package:flutter_firebase_chat_app/service/database_service.dart';
import 'package:flutter_firebase_chat_app/widgets/prayer/prayer_comment_item.dart';
import 'package:provider/provider.dart';

class PrayerComments extends StatelessWidget {
  final String docId;

  const PrayerComments({Key key, this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseService _dbService =
        Provider.of<DatabaseService>(context, listen: false);

    return StreamBuilder(
      stream: _dbService.getPrayerComments(docId),
      builder: (ctx, commentSnapshot) {
        if (commentSnapshot.connectionState == ConnectionState.waiting &&
            !commentSnapshot.hasData) return Text('');
        final List<PrayerComment> commentsList = commentSnapshot.data;
        print(docId);
        return ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: commentsList.length,
          itemBuilder: (ctx, index) {
            return PrayerCommentItem(prayerComment: commentsList[index]);
          },
        );
      },
    );
  }
}
