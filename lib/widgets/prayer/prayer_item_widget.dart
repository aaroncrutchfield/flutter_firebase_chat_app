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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FittedBox(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.all(4),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage(prayer.metadata.usrImageUrl),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 10,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FittedBox(
                        child: Text(DateFormat('MMM d, yyyy').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          prayer.metadata.docCreatedAt.millisecondsSinceEpoch),
                    ))), // created date
                    FittedBox(
                      fit: BoxFit.fill,
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
                                .headline2)), // update status
                  ],
                ),
              ),
            ],
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
