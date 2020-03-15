import 'package:androidArchitecture/ui/editing/EditorView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/widgets.dart";
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase/firebase.dart' as fb;

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
    _configureGoogleSignIn();
  }

  query() {
    debugPrint("Query it");
    var collectionName = "section";
    Firestore.instance.collection(collectionName).snapshots().listen((event) {
      debugPrint("Found collection section $collectionName  $event ");

      var l = event.documents.length;

      debugPrint("Found $l documents");
      event.documents.forEach((element) {
        debugPrint("row is $element - ${element['id']} = ${element['name']} ");
      });
    });
  }

  Future<void> _configure() async {
    final FirebaseApp app = await FirebaseApp.configure(
      name: "hello",
      options: firebaseOptions,
    );
    assert(app != null);
  }

  bool insert(String userid) {
    Map<String, String> document = {
      'userid': userid,
      'id': 'id22 4',
      'name': 'write test 33',
      'hello': 'worlddd'
    };

    try {
      Firestore.instance.collection("section")?.add(document);
      return true;
    } catch (e) {
      debugPrint("Something failed " + e.toString());
    }

    return false;
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

  void _configureGoogleSignIn() {}
}
