import 'dart:convert';

import 'package:androidArchitecture/domain/FirebaseRepository.dart';
import 'package:androidArchitecture/domain/model/OptionModel.dart';
import 'package:androidArchitecture/domain/model/TreeModel.dart';
import 'package:androidArchitecture/ui/editing/EditorView.dart';
import 'package:androidArchitecture/ui/editing/TechTreeDocument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../serializers.dart';

class TreeRepository {
  var firestore = FirebaseRepository.getInstance();

  Future<TreeModel> readModel(BuildContext context) async {
    var assetsPath = "assets/json/flutterTree.json";
//    var assetsPath = "assets/json/androidTree.json";

    String jsonString = await rootBundle.loadString(assetsPath);

    var a = jsonDecode(jsonString);

    var tree = serializers.deserializeWith(TreeModel.serializer, a);

    return tree;
  }

  /// Tries to insert document and returns true when insertion is successfull
  Future<bool> saveDocument(SectionDocument document) async {
    debugPrint("Adding document $document");
    return await firestore.insertDocument(
        _getSectionTableName(), document.getMap());
  }

  Stream<Iterable<SectionDocument>> getAllSections() {
    return firestore.getDocumentList(_getSectionTableName()).map(
          (event) => event.documents.map(
            (doc) => SectionDocument.fromFirebase(doc),
          ),
        );
  }

  String _getSectionTableName() {
    return kReleaseMode ? "section" : "section_debug";
  }
}
