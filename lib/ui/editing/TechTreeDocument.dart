import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TechTreeDocument {
  Map<String, String> getMap();
}

class SectionDocument extends TechTreeDocument {
  String id;
  String name;

  SectionDocument({
    this.name,
  });

  SectionDocument.fromFirebase(DocumentSnapshot doc) {
    this.id = doc.documentID;
    this.name = doc.data['name'];
  }

  @override
  String toString() {
    return 'SectionDocument{id: $id, fancyName: $name}';
  }

  @override
  Map<String, String> getMap() {
    return {'name': name};
  }
}

class LeafDocument extends TechTreeDocument {
  String id;
  String sectionId;
  String name;

  LeafDocument({this.sectionId, this.name});

  LeafDocument.fromFirebase(DocumentSnapshot doc) {
    this.id = doc.documentID;
    this.sectionId = doc['sectionId'];
    this.name = doc.data['name'];
  }

  @override
  Map<String, String> getMap() {
    return {'sectionId': sectionId, 'name': name};
  }
}
