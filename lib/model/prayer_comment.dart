import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_chat_app/model/metadata.dart';

class PrayerComment {
	static const COMMENT = 'comment';

	Metadata metadata;
	String comment;

	PrayerComment({this.metadata, this.comment});

	factory PrayerComment.fromFirestore(DocumentSnapshot snapshot) {
		Map data = snapshot.data;

		return PrayerComment(
			metadata: Metadata.fromFirestore(snapshot),
			comment: data[COMMENT],
		);
	}

	Map<String, dynamic> toMap() {
		return {
			Metadata.METADATA: metadata.toMap(),
			COMMENT: comment,
		};
	}


}