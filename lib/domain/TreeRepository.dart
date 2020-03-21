import 'package:androidArchitecture/domain/FirebaseRepository.dart';
import 'package:androidArchitecture/domain/UserDao.dart';
import 'package:androidArchitecture/ui/editing/TechTreeDocument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TreeRepository {
  static var TechIdAndroid = 'android';
  var firestore = FirebaseRepository.getInstance();

  User user;

  TreeRepository() {
    UserDao().getUserStream().listen((newUser) {
      user = newUser;
    });
  }

  /// Tries to insert document and returns true when insertion is successfull
  Future<bool> saveSectionDocument(SectionDocument document) async {
    debugPrint("Adding document $document");
    return await firestore.insertDocument(_getSectionTableName(),
        document.getMap()..putIfAbsent('author', () => user?.uid));
  }

  Future<bool> saveLeafDocument(LeafDocument document) async {
    debugPrint("Adding document $document");

    return await firestore.insertDocument(_getLeafTableName(),
        document.getMap()..putIfAbsent('author', () => user?.uid));
  }

  Stream<SectionDocument> getSectionById(String sectionId) {
    return firestore
        .getDocumentList(_getSectionTableName())
        .snapshots()
        .map((event) => SectionDocument.fromFirebase(
              event.documents
                  .firstWhere((element) => element.documentID == sectionId),
            ));
  }

  Stream<Iterable<SectionDocument>> getAllSections(String techId) {
    return firestore
        .getDocumentList(_getSectionTableName())
        .where('techId', isEqualTo: techId)
        .snapshots()
        .map(
          (event) => event.documents.map(
            (doc) => SectionDocument.fromFirebase(doc),
          ),
        );
  }

  Stream<Iterable<LeafDocument>> getLeafList(String sectionId) {
    return firestore.getDocumentList(_getLeafTableName()).snapshots().map(
          (event) => event.documents
              .where((element) => element.data['sectionId'] == sectionId)
              .map(
                (doc) => LeafDocument.fromFirebase(doc),
              ),
        );
  }

  bool _useDebugTable() {
    return !kReleaseMode;
  }

  String _getSectionTableName() {
    return _useDebugTable() ? "section_debug" : "section";
  }

  String _getLeafTableName() {
    return _useDebugTable() ? "leaf_debug" : "leaf";
  }
}
