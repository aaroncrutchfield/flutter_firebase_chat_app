import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_app/model/chat.dart';
import 'package:flutter_firebase_chat_app/model/metadata.dart';
import 'package:flutter_firebase_chat_app/model/prayer.dart';
import 'package:flutter_firebase_chat_app/model/prayer_details.dart';
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

  Future<UserData> getUserData(String uid) async {
    var snapshots = await firestore.collection('users').document(uid).get();

    return UserData.fromFirestore(snapshots);
  }

  Future<void> insertChatMessage(String uid, String message) async {
    getUserData(uid).then((userData) => firestore.collection('chat').add({
          Chat.TEXT: message,
          Chat.CREATED_AT: Timestamp.now(),
          Chat.USER_ID: userData.id,
          Chat.USERNAME: userData.username,
          Chat.USER_IMAGE: userData.imageUrl,
        }));
  }

  Future<void> insertNewUserData(UserData userData) async {
    return firestore.collection('users').document(userData.id).setData({
      UserData.EMAIL: userData.email,
      UserData.IMAGE_URL: userData.imageUrl,
      UserData.USERNAME: userData.username,
    }).catchError((onError) {
      print('insertUser error: $onError');
    });
  }

  Future<DocumentReference> insertNewPrayer(
    String uid,
    Prayer prayer,
    PrayerDetails details,
  ) async {
    return getUserData(uid).then((userData) {
      prayer.metadata = Metadata.fromUserData(userData);
      return firestore.collection('_prayer').add(prayer.toMap()).then(
          (prayerDoc) => prayerDoc.collection('details').add(details.toMap()));
    }).catchError((onError, stack) {
      print('insertPrayer error: $onError \n$stack');
    });
  }

  Stream<List<Prayer>> getPrayers() {
    var snapshots = firestore
        .collection('_prayer')
//        .orderBy(Metadata.DOCUMENT_CREATED_AT, descending: true)
        .snapshots();

    return snapshots.map((querySnap) => querySnap.documents
        .map((docSnap) => Prayer.fromFirestore(docSnap))
        .toList());
  }

  CollectionReference _prayerCollection(String uid) {
    return firestore
        .collection('_prayer')
        .document(uid)
        .collection('personal_prayers');
  }

  updatePrayerCount(Prayer prayer) {
    return firestore
        .collection('_prayer')
        .document(prayer.metadata.docId)
        .updateData({Prayer.PRAYER_COUNT: prayer.prayerCount + 1});
  }
}
