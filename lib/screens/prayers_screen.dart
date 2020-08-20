import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/model/prayer.dart';
import 'package:flutter_firebase_chat_app/service/database_service.dart';
import 'package:flutter_firebase_chat_app/widgets/prayer/prayer_item_widget.dart';
import 'package:provider/provider.dart';

class PrayersScreen extends StatefulWidget {
  @override
  _PrayersScreenState createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<PrayersScreen> {
  @override
  Widget build(BuildContext context) {
    DatabaseService _dbService =
        Provider.of<DatabaseService>(context, listen: false);

    return StreamBuilder(
      stream: _dbService.getPrayers(),
      builder: (ctx, prayerSnapshot) {
        print(prayerSnapshot.connectionState);
        print(prayerSnapshot.hasData);
        if (prayerSnapshot.connectionState == ConnectionState.waiting ||
            !prayerSnapshot.hasData) return Text('');
        final List<Prayer> prayerList = prayerSnapshot.data;
        print('Prayers: ${prayerList.length}');
        print(prayerList[0].metadata.usrUsername);
        return ListView.builder(
          itemCount: prayerList.length,
          itemBuilder: (ctx, index) => PrayerItemWidget(prayerList[index]),
        );
      },
    );
  }
}
