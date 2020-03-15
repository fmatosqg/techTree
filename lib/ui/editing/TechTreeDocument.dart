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
    this.name = doc.data['name'] as String;
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
