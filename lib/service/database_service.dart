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

    return snapshots.map((querySnap) =>
        querySnap.documents.map((docSnap) => Chat.fromFirestore(docSnap)).toList());
  }

  Future<UserData> getUserData(String uid) async {
  // Fixme doc is returning back null
    var doc = await firestore.collection('users').document(uid).get();
    
    return UserData.fromFirestore(doc);
  }

  Future<void> insertChatMessage(UserData userData, Timestamp now, String message) async {
    firestore.collection('chat').add({
      Chat.TEXT: message,
      Chat.CREATED_AT: now,
      Chat.USER_ID: userData.id,
      Chat.USERNAME: userData.username,
      Chat.USER_IMAGE: userData.imageUrl,
    });
  }

  Future<void> insertNewUserData(UserData userData) async {
    return firestore.collection('users').document(userData.id).setData({
      UserData.EMAIL: userData.email,
      UserData.IMAGE_URL: userData.imageUrl,
      UserData.USERNAME: userData.username,
    });
  }
}