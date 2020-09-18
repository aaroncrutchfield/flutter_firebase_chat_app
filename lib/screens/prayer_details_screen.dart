import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/model/prayer.dart';
import 'package:flutter_firebase_chat_app/widgets/chat/new_message.dart';
import 'package:flutter_firebase_chat_app/widgets/prayer/prayer_comments.dart';
import 'package:flutter_firebase_chat_app/widgets/prayer/prayer_details_item.dart';
import 'package:flutter_firebase_chat_app/widgets/prayer/prayer_form.dart';

class PrayerDetailsScreen extends StatefulWidget {
  final Prayer prayer;

  PrayerDetailsScreen(this.prayer);

  @override
  _PrayerDetailsScreenState createState() => _PrayerDetailsScreenState();
}

class _PrayerDetailsScreenState extends State<PrayerDetailsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                PrayerDetailsItem(widget.prayer),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Comments', style: Theme.of(context).textTheme.headline1),
                ),
                PrayerComments(docId: widget.prayer.metadata.docId),
              ],
            ),
          ),
          UserInput.comment(docId: widget.prayer.metadata.docId),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 64.0),
        child: FloatingActionButton(
          onPressed: _addPrayerDetail,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  _addPrayerDetail() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return PrayerForm.update(prayer: widget.prayer, scaffoldKey: _scaffoldKey,);
        });
  }
}
