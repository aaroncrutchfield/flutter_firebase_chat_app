import 'package:flutter/material.dart';

class PrayerForm extends StatefulWidget {
  final void Function(
      String title,
      String details
      ) submitPrayerForm;

  const PrayerForm({Key key, this.submitPrayerForm}) : super(key: key);
  @override
  _PrayerFormState createState() => _PrayerFormState();
}

class _PrayerFormState extends State<PrayerForm> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _details;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New Prayer Request'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              key: ValueKey('title'),
              validator: (titleInput) {
                if (titleInput.isEmpty || titleInput.length < 4) {
                  return 'Title must be at least 4 characters long.';
                }
                return null;
              },
              onSaved: (titleInput) => _title = titleInput,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              key: ValueKey('details'),
              validator: (detailsInput) {
                if (detailsInput.isEmpty || detailsInput.length < 4) {
                  return 'Details must be at least 4 characters long.';
                }
                return null;
              },
              onSaved: (detailsInput) => _details = detailsInput,
	            keyboardType: TextInputType.multiline,
              decoration: InputDecoration(labelText: 'Details'),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
	                onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text('OK'),
                  onPressed: _validatePrayer,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _validatePrayer() {
    final isValid = _formKey.currentState.validate();
    // TODO may not need to unfocus
    FocusScope.of(context).unfocus();
    
    if (isValid) {
      
    }
  }
}
