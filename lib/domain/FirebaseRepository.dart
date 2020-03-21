import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import "package:flutter/widgets.dart";
import 'package:google_sign_in/google_sign_in.dart';

import '../secrets.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

/// Entry point for firebase configurations.
///
/// Official info at
/// - https://firebase.google.com/docs/web/setup#from-the-cdn
/// - https://pub.dev/packages/cloud_firestore_web
/// - https://pub.dev/packages/cloud_firestore#-readme-tab-
///
/// Create file ../secrets.dart containing info obtained from https://console.firebase.google.com/
///
///
/// import 'package:firebase_core/firebase_core.dart';
///
/// var firebaseOptions = FirebaseOptions(
///   googleAppID: <value>,
///   apiKey: <value>,
///   databaseURL: <value>,
///   projectID: <value>,
/// );

class FirebaseRepository {
  static var _instance = FirebaseRepository();

  static FirebaseRepository getInstance() => _instance;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
//      'email',
    ],
  );

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  init() async {
    _configure();
  }

  Future<void> _configure() async {
    final FirebaseApp app = await FirebaseApp.configure(
      name: "hello",
      options: firebaseOptions,
    );
    assert(app != null);
  }

  /// Inserts document and returns true if successfull
  Future<bool> insertDocument(
      String tableName, Map<String, String> document) async {
    try {
      var d = await Firestore.instance.collection(tableName)?.add(document);

      debugPrint(
          "Success inserting document on '$tableName': '$document': '$d'");
      return true;
    } catch (e) {
      print("Error inserting document on '$tableName': '$document'");
      return false;
    }
  }

  Stream<QuerySnapshot> getDocumentList(String tableName) {
    return Firestore.instance.collection(tableName).snapshots();
  }
}
