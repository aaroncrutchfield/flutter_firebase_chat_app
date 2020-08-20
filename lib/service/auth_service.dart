import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

	final FirebaseAuth _auth = FirebaseAuth.instance;


	Future<FirebaseUser> get user async {
		return _auth.currentUser();
	}

	// sign in anon
	Future<AuthResult> signInAnon() async {
		try {
			return _auth.signInAnonymously();
		} catch (e) {
			print(e.toString());
			return null;
		}
	}

	// sign in with email and password
	Future<AuthResult> signInWithEmailAndPassword(String email, String password) async {
		try {
			return await _auth.signInWithEmailAndPassword(email: email, password: password);
		} catch (error) {
			print('signInWithEmail $error');
			return null;
		}
	}

	// register with email and password
	Future<AuthResult> registerWithEmailAndPassword(String email, String password) async {
		try {
			return await _auth.createUserWithEmailAndPassword(email: email, password: password);
		} catch (error) {
			print('registerWithEmail $error');
			return null;
		}
	}

	// sign out
	Future<void> signOut() async {
		try {
			return _auth.signOut();
		} catch (error) {
			print(error.toString());
			return null;
		}
	}

}