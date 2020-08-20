import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_chat_app/model/metadata.dart';
import 'package:flutter_firebase_chat_app/model/user_data.dart';

class Prayer {
  static const TITLE = 'title';
  static const ANSWERED = 'answered';
  static const UPDATED = 'updated';
  static const IS_PRIVATE = 'isPrivate';

	Metadata metadata;
	String title;
	bool answered;
	bool updated;
	bool isPrivate;

	Prayer({this.metadata, this.title, this.answered = false, this.updated = false, this.isPrivate = false});

	factory Prayer.fromFirestore(DocumentSnapshot snapshot) {
		Map data = snapshot.data;

		return Prayer(
			metadata: Metadata.fromFirestore(snapshot),
			title: data[TITLE],
			answered: data[ANSWERED],
			updated: data[UPDATED],
			isPrivate: data[IS_PRIVATE],
		);
	}

	Map<String, dynamic> toMap() {
		return {
			Metadata.METADATA: metadata.toMap(),
			TITLE: title,
			ANSWERED: answered,
			UPDATED: updated,
			IS_PRIVATE: isPrivate,
		};
	}
}