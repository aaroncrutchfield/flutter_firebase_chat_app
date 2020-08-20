import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_chat_app/model/user_data.dart';

class Metadata {
	static const METADATA = '_METADATA';
	static const DOCUMENT_ID = '_DOC_ID';
	static const DOCUMENT_CREATED_AT = '_DOC_CREATED_AT';
	static const USER_ID = '_USR_ID';
	static const USER_IMAGE_URL = '_USR_IMAGE_URL';
	static const USER_USERNAME = '_USR_USERNAME';

	String docId;
	Timestamp docCreatedAt;
	String usrId;
	String usrImageUrl;
	String usrUsername;

	Metadata({this.docId, this.docCreatedAt, this.usrId, this.usrImageUrl,
      this.usrUsername});

	factory Metadata.fromFirestore(DocumentSnapshot snapshot) {
		Map data = snapshot.data;

		return Metadata(
			docId: snapshot.documentID,
			docCreatedAt: data[METADATA][DOCUMENT_CREATED_AT],
			usrId: data[METADATA][USER_ID],
			usrImageUrl: data[METADATA][USER_IMAGE_URL],
			usrUsername: data[METADATA][USER_USERNAME],
		);
	}

	factory Metadata.fromUserData(UserData userData) {

		return Metadata(
			docCreatedAt: Timestamp.now(),
			usrId: userData.id,
			usrImageUrl: userData.imageUrl,
			usrUsername: userData.username,
		);
	}

	Map toMap() {
		return {
			DOCUMENT_CREATED_AT: docCreatedAt,
			USER_ID: usrId,
			USER_IMAGE_URL: usrImageUrl,
			USER_USERNAME: usrUsername,
		};
	}

}