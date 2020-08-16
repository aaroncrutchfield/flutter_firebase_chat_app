import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrayerItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: FittedBox(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Container(
                      margin: EdgeInsets.all(2),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Jane Cooper', style: Theme.of(context).textTheme.headline2), // username
                      SizedBox(height: 8),
                      Text(
                        'My husband needs he from back pains',
                        softWrap: true,
                        style: Theme.of(context).textTheme.headline1,
                      ), // prayer title
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FittedBox(child: Text('12/12/20')), // created date
                    FittedBox(
                        child: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.thumb_up),
                            label: Text('12'))), // prayers count
                    FittedBox(child: Text('Update', style: Theme.of(context).textTheme.headline2)), // update status
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
