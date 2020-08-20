import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
	static const ID = 'userId';
	static const EMAIL = 'email';
	static const IMAGE_URL = 'image_url';
	static const USERNAME = 'username';

	String id;
	String email;
	String imageUrl;
	String username;

	UserData({this.id, this.email, this.imageUrl, this.username});

	factory UserData.anon(String uid) {
		return UserData(
			id: uid,
			email: 'anon',
			imageUrl: '',
			username: 'Anonymous',
    );
	}

	factory UserData.fromFirestore(DocumentSnapshot snapshot) {
		Map data = snapshot.data;

		return UserData(
			id: snapshot.documentID,
			imageUrl: data[IMAGE_URL],
			username: data[USERNAME],
			email: data[EMAIL],
		);
	}
}
