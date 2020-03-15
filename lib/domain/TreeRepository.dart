import 'package:androidArchitecture/domain/FirebaseRepository.dart';
import 'package:androidArchitecture/ui/editing/TechTreeDocument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TreeRepository {
  var firestore = FirebaseRepository.getInstance();

  /// Tries to insert document and returns true when insertion is successfull
  Future<bool> saveSectionDocument(SectionDocument document) async {
    debugPrint("Adding document $document");
    return await firestore.insertDocument(
        _getSectionTableName(), document.getMap());
  }

  Future<bool> saveLeafDocument(LeafDocument document) async {
    debugPrint("Adding document $document");
    return await firestore.insertDocument(
        _getLeafTableName(), document.getMap());
  }

  Stream<Iterable<SectionDocument>> getAllSections() {
    return firestore.getDocumentList(_getSectionTableName()).map(
          (event) => event.documents.map(
            (doc) => SectionDocument.fromFirebase(doc),
          ),
        );
  }

  Stream<Iterable<LeafDocument>> getLeafList(String sectionId) {
    return firestore.getDocumentList(_getLeafTableName()).map(
          (event) => event.documents
              .where((element) => element.data['sectionId'] == sectionId)
              .map(
                (doc) => LeafDocument.fromFirebase(doc),
              ),
        );
  }

  String _getSectionTableName() {
    return kReleaseMode ? "section" : "section_debug";
  }

  String _getLeafTableName() {
    return kReleaseMode ? "leaf" : "leaf_debug";
  }
}
