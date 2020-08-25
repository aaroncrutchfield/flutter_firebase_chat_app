import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/model/prayer.dart';
import 'package:flutter_firebase_chat_app/model/prayer_details.dart';
import 'package:flutter_firebase_chat_app/service/auth_service.dart';
import 'package:flutter_firebase_chat_app/service/database_service.dart';
import 'package:provider/provider.dart';

class PrayerForm extends StatefulWidget {
	final bool isUpdate;
	final Prayer prayer;

	const PrayerForm.newPrayer({Key key, this.isUpdate: false, this.prayer})
			: super(key: key);

	const PrayerForm.update(
			{Key key, this.isUpdate: true, @required this.prayer})
			: super(key: key);


	@override
	_PrayerFormState createState() => _PrayerFormState();
}

class _PrayerFormState extends State<PrayerForm> {
	final _formKey = GlobalKey<FormState>();
	DatabaseService _dbService;
	AuthService _authService;

	String _title;
	String _details;

	@override
	void initState() {
		super.initState();
		Future.delayed(Duration.zero).then((_) {
			_dbService = Provider.of<DatabaseService>(context, listen: false);
			_authService = Provider.of<AuthService>(context, listen: false);
		});
	}

	Future<void> _validatePrayer() async {
		final isValid = _formKey.currentState.validate();
		// TODO may not need to unfocus
		FocusScope.of(context).unfocus();

		FirebaseUser user = await _authService.user;

		if (isValid) {
			_formKey.currentState.save();
			var prayerDetails = PrayerDetails(details: _details.trim());
			if (widget.isUpdate) {
				_dbService.insertNewPrayer(
					user.uid,
					Prayer(title: _title.trim()),
					prayerDetails,
				);
			} else {
				_dbService.insertNewPrayerDetail(widget.prayer, prayerDetails);
			}
			Navigator.of(context).pop();
		}
	}

	@override
	Widget build(BuildContext context) {
		return AlertDialog(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.all(Radius.circular(16.0)),
			),
			content: Form(
				key: _formKey,
				child: Column(
					mainAxisSize: MainAxisSize.min,
					crossAxisAlignment: CrossAxisAlignment.end,
					children: <Widget>[
						if (!widget.isUpdate) TextFormField(
							key: ValueKey('title'),
							validator: (titleInput) {
								if (titleInput.isEmpty || titleInput.length < 4) {
									return 'Title must be at least 4 characters long.';
								}
								return null;
							},
							onSaved: (titleInput) => _title = titleInput,
							decoration: InputDecoration(

								hintText: 'Title',
								border: InputBorder.none,
								filled: true,
								fillColor: Colors.grey[200],
							),
						),
						if (!widget.isUpdate) SizedBox(height: 16),
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
							minLines: 4,
							maxLines: 8,
							decoration: InputDecoration(
								hintText: widget.isUpdate ? 'Update details' : 'Details',
								border: InputBorder.none,
								filled: true,
								fillColor: Colors.grey[200],
							),
						),
						SizedBox(height: 16),
						Row(
							mainAxisAlignment: MainAxisAlignment.end,
							mainAxisSize: MainAxisSize.min,
							children: <Widget>[
								FlatButton(
									child: Text(
										'Cancel',
										style: TextStyle(color: Theme
												.of(context)
												.primaryColor),
									),
									onPressed: () => Navigator.of(context).pop(),
								),
								RaisedButton(
									child: Text('OK'),
									onPressed: _validatePrayer,
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.all(Radius.circular(5.0)),
									),
								),
							],
						)
					],
				),
			),
		);
	}
}
