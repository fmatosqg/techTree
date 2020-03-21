import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'FirebaseRepository.dart';

class UserDao {
  var _firebaseAuth = FirebaseRepository.getInstance().firebaseAuth;

  Future<User> getUser() async {
    return getUserStream().first;
  }

  /// Returns a stream of User that emits when the user changes (not when the database changes)
  ///
  Stream<User> _getUserStreamUnsafe() {
    return _firebaseAuth.onAuthStateChanged
        .map((event) {
          debugPrint(
              "Event here is $event ${event?.uid} ${event?.displayName}");
          return event;
        })
        .map((firebaseUser) => Firestore.instance
            .collection(_getUserTableName())
            .document(firebaseUser?.uid ?? User.anonymousUid))
        .asyncMap((event) => event.get())
        .map((event) => User.fromDocument(event));
  }

  Stream<User> getUserStream() {
    return StreamTransformer<User, User>.fromHandlers(
        handleData: (User user, EventSink sink) {
      sink.add(user);
    }, handleError: (error, stacktrace, sink) {
      debugPrint("Cannot retrieve user row ${error}");
      sink.add(User.asAnonymous());
    }).bind(_getUserStreamUnsafe()).handleError((error) {
      debugPrint("Another error");
    });
  }

  _getUserTableName() {
    return "user";
  }

  Future<User> whatevs(Stream<DocumentSnapshot> doc) async {
    var d = await doc.first;

    return User.fromDocument(d);
  }
}

class User {
  static var anonymousUid = '0';

  bool _isAdmin;

  String name;

  bool isEditor;

  String uid;

  User() {
    _isAdmin = false;
    isEditor = false;
    uid = '';
  }

  User.asAnonymous() {
    isEditor = false;
    _isAdmin = false;
    uid = anonymousUid;
    name = 'Anonymous';
  }

  User.fromDocument(DocumentSnapshot doc) {
    debugPrint("Snapshot user is ${doc.toString()}");
    _isAdmin = doc['admin'];
    name = doc['name'];
    isEditor = doc['editor'];
    uid = doc.documentID;
  }
}
