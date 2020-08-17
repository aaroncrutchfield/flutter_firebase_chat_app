import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_app/model/user_data.dart';

import 'database_service.dart';

class AuthService {

	final FirebaseAuth _auth = FirebaseAuth.instance;
	var _user;

	// create user obj based on firebase user
	Future<UserData> _userFromFirebaseUser(FirebaseUser user) async {
		print('uid: ${user.uid}');

		return DatabaseService().getUserData(user.uid);
	}

	// auth change user stream
//	Stream<UserData> get user {
//		return _auth.onAuthStateChanged
//		//.map((FirebaseUser user) => _userFromFirebaseUser(user));
//				.asyncMap(_userFromFirebaseUser);
//	}

	Future<UserData> get userData async {
		var firebaseUser = await _auth.currentUser();
		return _userFromFirebaseUser(firebaseUser);
	}

	Future<FirebaseUser> get user async {
		if(_user == null)
			_user = _auth.currentUser();

		return _user;
	}

	// sign in anon
	Future signInAnon() async {
		try {
			AuthResult result = await _auth.signInAnonymously();
			FirebaseUser user = result.user;
			return _userFromFirebaseUser(user);
		} catch (e) {
			print(e.toString());
			return null;
		}
	}

	// sign in with email and password
	Future signInWithEmailAndPassword(String email, String password) async {
		try {
			AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
			FirebaseUser user = result.user;
			return user;
		} catch (error) {
			print(error.toString());
			return null;
		}
	}

	// register with email and password
	Future<AuthResult> registerWithEmailAndPassword(String email, String password) async {
		try {
			AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
			FirebaseUser user = result.user;
			// create a new document for the user with the uid
//			var userData = UserData(
//					id: user.uid,
//					email: email,
//					imageUrl: imageUrl,
//					username: username,
//				);
//			await DatabaseService().insertNewUserData(userData);
			return result;
		} catch (error) {
			print(error.toString());
			return null;
		}
	}

	// sign out
	Future signOut() async {
		try {
			return await _auth.signOut();
		} catch (error) {
			print(error.toString());
			return null;
		}
	}

}