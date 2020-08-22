import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_chat_app/model/metadata.dart';
import 'package:flutter_firebase_chat_app/model/user_data.dart';

class Prayer {
  static const TITLE = 'title';
  static const ANSWERED = 'answered';
  static const UPDATED = 'updated';
  static const IS_PRIVATE = 'isPrivate';
  static const PRAYER_COUNT = 'prayerCount';

	Metadata metadata;
	String title;
	bool answered;
	bool updated;
	bool isPrivate;
	int prayerCount;

	Prayer({this.metadata, this.title, this.answered = false, this.updated = false, this.isPrivate = false, this.prayerCount = 0});

	factory Prayer.fromFirestore(DocumentSnapshot snapshot) {
		Map data = snapshot.data;

		return Prayer(
			metadata: Metadata.fromFirestore(snapshot),
			title: data[TITLE],
			answered: data[ANSWERED],
			updated: data[UPDATED],
			isPrivate: data[IS_PRIVATE],
			prayerCount: data[PRAYER_COUNT],
		);
	}

	Map<String, dynamic> toMap() {
		return {
			Metadata.METADATA: metadata.toMap(),
			TITLE: title,
			ANSWERED: answered,
			UPDATED: updated,
			IS_PRIVATE: isPrivate,
			PRAYER_COUNT: prayerCount,
		};
	}

  @override
  String toString() {
    return 'Prayer{title: $title, answered: $answered, updated: $updated, isPrivate: $isPrivate, prayerCount: $prayerCount}';
  }
}