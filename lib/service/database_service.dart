import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_app/model/chat.dart';
import 'package:flutter_firebase_chat_app/model/user_data.dart';

class DatabaseService {
  final firestore = Firestore.instance;
  final storage = FirebaseStorage.instance;

  var user;

  Stream<List<Chat>> getChatList() {
    var snapshots = firestore
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return snapshots.map((querySnap) => querySnap.documents
        .map((docSnap) => Chat.fromFirestore(docSnap))
        .toList());
  }

  Stream<UserData> getUserData(String uid) {
    // Fixme doc is returning back null
    var snapshots = Firestore.instance
        .collection('users')
        .document(uid).snapshots();

    return snapshots.map((event) => UserData.fromFirestore(event));
  }

  Future<void> insertChatMessage(String uid, String message) async {
    return getUserData(uid).asyncMap((event) async => Firestore.instance.collection('chat').add({
      Chat.TEXT: message,
      Chat.CREATED_AT: Timestamp.now(),
      Chat.USER_ID: event.id,
      Chat.USERNAME: event.username,
      Chat.USER_IMAGE: event.imageUrl,
    }));
  }

  Future<void> insertNewUserData(UserData userData) async {
    return firestore.collection('users').document(userData.id).setData({
      UserData.EMAIL: userData.email,
      UserData.IMAGE_URL: userData.imageUrl,
      UserData.USERNAME: userData.username,
    });
  }
}
