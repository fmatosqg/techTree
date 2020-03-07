import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/widgets.dart";
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";

import '../secrets.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

/// Entry point for firebase configurations.
///
/// Official info at
/// - https://firebase.google.com/docs/web/setup#from-the-cdn
/// - https://pub.dev/packages/cloud_firestore_web
/// - https://pub.dev/packages/cloud_firestore#-readme-tab-
///
/// Create file ../secrets.dart containing info obtained from https://console.firebase.google.com/:
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
///
class FirebaseRepository {
  static var _instance = FirebaseRepository();

  static FirebaseRepository getInstance() => _instance;

  init() async {
    _configure();
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
    print("Configured '$app'");
  }

//  Future<void> _allApps() async {
//    final List<FirebaseApp> apps = await FirebaseApp.allApps();
//    print('Currently configured apps: $apps');
//  }
//
//  Future<void> _options() async {
//    final FirebaseApp app = await FirebaseApp.appNamed(name);
//    final FirebaseOptions options = await app?.options;
//    print('Current options for app $name: $options');
//  }
}
