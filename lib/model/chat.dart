import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
	static const TEXT = 'text';
	static const USERNAME = 'username';
	static const USER_IMAGE = 'userImage';
	static const USER_ID = 'userId';
	static const CREATED_AT = 'createdAt';

	String id;
	String userId;
	Timestamp createdAt;
	String message;
	String username;
	String userImage;

	Chat({this.id, this.createdAt, this.message, this.username, this.userImage, this.userId});

	factory Chat.fromFirestore(DocumentSnapshot snapshot) {
		Map data = snapshot.data;

		return Chat(
			id: snapshot.documentID,
			createdAt: data[CREATED_AT],
			message: data[TEXT],
			username: data[USERNAME],
			userImage: data[USER_IMAGE],
			userId: data[USER_ID],
		);
	}


}