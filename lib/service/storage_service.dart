import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
	final _storage = FirebaseStorage.instance;

	Future<String> uploadUserImage(String uid, File image) async {
		final ref = _storage
				.ref()
				.child('user_images')
				.child('$uid.jpg');

		await ref.putFile(image).onComplete;
		String url = await ref.getDownloadURL();

		return url;
	}
}