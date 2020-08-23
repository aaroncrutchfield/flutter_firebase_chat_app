import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/model/prayer.dart';
import 'package:flutter_firebase_chat_app/widgets/prayer/prayer_details_item.dart';

class PrayerDetailsScreen extends StatelessWidget {
  final Prayer prayer;

  PrayerDetailsScreen(this.prayer);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
	    child: PrayerDetailsItem(prayer),
        ),
      ),
    );
  }
}
