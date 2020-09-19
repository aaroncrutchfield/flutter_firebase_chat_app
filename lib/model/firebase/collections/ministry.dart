import 'package:cloud_firestore/cloud_firestore.dart';

class Ministry {
	static const String TITLE = 'title';
	static const String DEPT_HEAD = 'deptHead';
	static const String IMAGE_URL = 'imageUrl';

	String id;
	String title;
	String deptHead;
	String imageUrl;

	Ministry({this.id, this.title, this.deptHead, this.imageUrl});

	factory Ministry.fromFirestore(DocumentSnapshot snapshot) {
		Map data = snapshot.data;

		return Ministry(
			id: snapshot.documentID,
			title: data[TITLE],
			deptHead: data[DEPT_HEAD],
			imageUrl: data[IMAGE_URL],
		);
	}

	Map<String, dynamic> toMap() {
		return {
			TITLE: title,
			DEPT_HEAD: deptHead,
			IMAGE_URL: imageUrl
		};
	}
}