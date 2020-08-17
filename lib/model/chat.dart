import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
	static const TEXT = 'text';
	static const USERNAME = 'username';
	static const USER_IMAGE = 'userImage';
	static const USER_ID = 'userId';

	String id;
	String userId;
	String message;
	String username;
	String userImage;

	Chat({this.id, this.message, this.username, this.userImage, this.userId});

	factory Chat.fromFirestore(DocumentSnapshot snap) {
		Map data = snap.data;

		return Chat(
			id: snap.documentID,
			message: data[TEXT],
			username: data[USERNAME],
			userImage: data[USER_IMAGE],
			userId: data[USER_ID],
		);
	}


}