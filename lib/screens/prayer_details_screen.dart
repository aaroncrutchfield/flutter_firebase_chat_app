import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/model/prayer.dart';
import 'package:flutter_firebase_chat_app/widgets/chat/new_message.dart';
import 'package:flutter_firebase_chat_app/widgets/prayer/prayer_details_item.dart';
import 'package:flutter_firebase_chat_app/widgets/prayer/prayer_form.dart';

class PrayerDetailsScreen extends StatefulWidget {
  final Prayer prayer;

  PrayerDetailsScreen(this.prayer);

  @override
  _PrayerDetailsScreenState createState() => _PrayerDetailsScreenState();
}

class _PrayerDetailsScreenState extends State<PrayerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            PrayerDetailsItem(widget.prayer),
            UserInput.comment(docId: widget.prayer.metadata.docId),
          ],
        ),
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
          return PrayerForm.update(prayer: widget.prayer);
        });
  }
}
