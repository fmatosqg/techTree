import 'dart:convert';

import 'package:androidArchitecture/domain/model/OptionModel.dart';
import 'package:androidArchitecture/domain/model/TreeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../serializers.dart';

class TreeRepository {
  Future<TreeModel> readModel(BuildContext context) async {
    var assetsPath = "assets/json/flutterTree.json";
//    var assetsPath = "assets/json/androidTree.json";

    String jsonString = await rootBundle.loadString(assetsPath);

    var a = jsonDecode(jsonString);

    var tree = serializers.deserializeWith(TreeModel.serializer, a);

    return tree;
  }
}
