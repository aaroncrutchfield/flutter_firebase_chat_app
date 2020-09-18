import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat_app/model/prayer_comment.dart';
import 'package:intl/intl.dart';

class PrayerCommentItem extends StatelessWidget {
  final PrayerComment prayerComment;

  PrayerCommentItem({this.prayerComment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, top: 4.0, right: 8.0, bottom: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          NetworkImage(prayerComment.metadata.usrImageUrl),
                      radius: 24,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(prayerComment.metadata.usrUsername,
                              style: Theme.of(context).textTheme.headline5),
                          Text(
                            DateFormat('MMM d, yyyy').format(
                              DateTime.fromMillisecondsSinceEpoch(prayerComment
                                  .metadata
                                  .docCreatedAt
                                  .millisecondsSinceEpoch),
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                prayerComment.comment,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
