import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/widgets/prayer/prayer_item_widget.dart';

class PrayersScreen extends StatefulWidget {
  @override
  _PrayersScreenState createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<PrayersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: 6,
          itemBuilder: (ctx, index) {
            return PrayerItemWidget();
          }),
    );
  }
}


