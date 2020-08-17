import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_app/model/chat.dart';

class DatabaseService {
  final auth = FirebaseAuth.instance;
  final firestore = Firestore.instance;
  final storage = FirebaseStorage.instance;


  DatabaseService();

  Future<FirebaseUser> getCurrentUser() async {
    return await auth.currentUser();
  }

  Stream<List<Chat>> getChatList() {
    var snapshots = firestore
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return snapshots.map((querySnap) =>
        querySnap.documents.map((docSnap) => Chat.fromFirestore(docSnap)).toList());
  }
}
