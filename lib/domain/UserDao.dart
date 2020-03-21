import 'dart:async';

import 'package:androidArchitecture/domain/ServiceLocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'FirebaseRepository.dart';

class UserDao {
  final _firebaseAuth = FirebaseRepository.getInstance().firebaseAuth;

  final TableNames _tableNames;

  UserDao(this._tableNames);

  Future<String> getUserId() async {
    var user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  /// Returns a stream of User that emits when the user changes (not when the database changes)
  ///
  ///
  Stream<User> getUserStream() {
    return _firebaseAuth.onAuthStateChanged
        .asyncMap((user) => _firebaseAuthToDomainUser(user).first);
  }

  _getUserTableName() {
    return _tableNames.userDao;
  }

  /// Finds a User in firestore associated with FirebaseUser
  Stream<User> _firebaseAuthToDomainUser(FirebaseUser firebaseUser) {
    if (firebaseUser?.isAnonymous ?? true) {
      return Stream.fromFuture(Future.microtask(() =>
          User.asAnonymousWithUid(firebaseUser?.uid ?? User.anonymousUid)));
    } else {
      return StreamTransformer<DocumentSnapshot, User>.fromHandlers(
        handleData: (DocumentSnapshot documentSnapshot, EventSink sink) {
          sink.add(User.fromDocument(documentSnapshot));
        },
        handleError: (error, stacktrace, sink) {
          debugPrint("Cannot retrieve user row ${error}");
          sink.add(
              User.asAnonymousWithUid(firebaseUser?.uid ?? User.anonymousUid));
        },
      ).bind(Firestore.instance
          .collection(_getUserTableName())
          .document(firebaseUser?.uid ?? User.anonymousUid)
          .snapshots());
    }
  }
}

class User {
  static final anonymousUid = '0';

  final bool isAdmin;

  final String name;

  final bool isEditor;

  final String uid;

  User.asAnonymousWithUid(String uid)
      : uid = uid,
        isEditor = false,
        isAdmin = false,
        name = 'Anonymous';

  User.asAnonymous()
      : uid = anonymousUid,
        isEditor = false,
        isAdmin = false,
        name = 'Anonymous w/o id';

  User.fromDocument(DocumentSnapshot doc)
      : uid = doc.documentID,
        isEditor = doc['editor'],
        isAdmin = doc['admin'],
        name = doc['name'];
}
