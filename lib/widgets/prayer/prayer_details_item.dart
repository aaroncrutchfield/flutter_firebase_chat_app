import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/model/prayer.dart';
import 'package:flutter_firebase_chat_app/model/prayer_details.dart';
import 'package:flutter_firebase_chat_app/service/database_service.dart';
import 'package:flutter_firebase_chat_app/widgets/scrolling_page_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PrayerDetailsItem extends StatefulWidget {
  final Prayer prayer;

  PrayerDetailsItem(this.prayer);

  @override
  _PrayerDetailsItemState createState() => _PrayerDetailsItemState();
}

class _PrayerDetailsItemState extends State<PrayerDetailsItem> {
  PageController controller = PageController();

  int docCount = 0;

  void _pageChanged(int value) {

  }

  @override
  Widget build(BuildContext context) {
    DatabaseService _databaseService = Provider.of<DatabaseService>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        NetworkImage(widget.prayer.metadata.usrImageUrl),
                    radius: 40,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(widget.prayer.title,
                            style: Theme.of(context).textTheme.headline5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              DateFormat('MMM d, yyyy').format(
                                DateTime.fromMillisecondsSinceEpoch(widget
                                    .prayer
                                    .metadata
                                    .docCreatedAt
                                    .millisecondsSinceEpoch),
                              ),
                              style: TextStyle(color: Colors.black),
                            ),
                            FlatButton.icon(
                                onPressed: () {
                                  return _databaseService
                                      .updatePrayerCount(widget.prayer);
                                },
                                icon: Icon(Icons.thumb_up),
                                label: Text('${widget.prayer.prayerCount}')),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            StreamBuilder(
                stream: _databaseService.getPrayerDetails(widget.prayer),
                builder: (ctx, detailsSnapshot) {
                  print(
                      'details connections: ${detailsSnapshot.connectionState}');
                  print('details has data: ${detailsSnapshot.hasData}');
                  if (detailsSnapshot.connectionState ==
                          ConnectionState.waiting ||
                      !detailsSnapshot.hasData) return Text('');
                  final List<PrayerDetails> detailsDocs = detailsSnapshot.data;
                  docCount = detailsDocs.length;
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        child: PageView.builder(
                          onPageChanged: _pageChanged,
                          controller: controller,
                          itemCount: detailsDocs.length,
                          itemBuilder: (ctx, index) => Text(
                            detailsDocs[index].details,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                      ScrollingPageIndicator(
                        dotColor: Colors.grey,
                        dotSelectedColor: Colors.amber,
                        controller: controller,
                        itemCount: docCount,
                      )
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
