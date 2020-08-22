import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat_app/model/prayer.dart';
import 'package:flutter_firebase_chat_app/service/database_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PrayerItemWidget extends StatelessWidget {
  final Prayer prayer;

  PrayerItemWidget(this.prayer);

  @override
  Widget build(BuildContext context) {
    print(prayer.toString());
    DatabaseService _databaseService = Provider.of<DatabaseService>(context);

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: FittedBox(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Container(
                        margin: EdgeInsets.all(2),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(prayer.metadata.usrImageUrl),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(prayer.metadata.usrUsername,
                            style: Theme.of(context)
                                .textTheme
                                .headline2), // username
                        SizedBox(height: 8),
                        Text(
                          prayer.title,
                          softWrap: true,
                          style: Theme.of(context).textTheme.headline1,
                        ), // prayer title
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FittedBox(
                          child: Text(DateFormat('MMM d, yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            prayer.metadata.docCreatedAt.millisecondsSinceEpoch),
                      ))), // created date
                      FittedBox(
                        child: FlatButton.icon(
                            onPressed: () {
                              return _databaseService.updatePrayerCount(prayer);
                            },
                            icon: Icon(Icons.thumb_up),
                            label: Text('${prayer.prayerCount}')),
                      ), // prayers count
                      FittedBox(
                          child: Text('Update',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3)), // update status
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 2.0,
          indent: 16.0,
          endIndent: 16.0,
        ),
      ],
    );
  }
}
