import 'dart:convert';

import 'package:androidArchitecture/domain/model/OptionModel.dart';
import 'package:androidArchitecture/domain/model/TreeModel.dart';
import 'package:androidArchitecture/domain/model/SectionModel.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../serializers.dart';

/// Allows the user to select among a list of choices.
///
class SelectView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectViewState();
  }
}

class _SelectViewState extends State<SelectView> {
  OptionListModel model;

  _SelectViewState();

  Future<OptionListModel> readModel(BuildContext context) async {
    var assetsPath = "assets/json/flutterTree.json";

//    debugPrint("Load asset $assetsPath");
    String jsonString = await rootBundle.loadString(assetsPath);

    var a = jsonDecode(jsonString);

    return serializers
        .deserializeWith(TreeModel.serializer, a)
        .options
        .toList()
        .first;
  }

  @override
  void initState() {
    super.initState();

    readModel(context).then((value) {
      setState(() {
        debugPrint(value.toString());
        model = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 20,
      children: model?.values
              ?.toList()
              ?.map(
                (optionModel) => RaisedButton(
                  child: Text(optionModel.name),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  )),
                  disabledColor: Color.fromARGB(255, 100, 100, 00),
                  color: Color.fromARGB(255, 100, 100, 200),
                  onPressed: () {
                    readModel(context);
                    debugPrint("Hello ${optionModel.name}");
                  },
                ),
              )
              ?.toList() ??
          [],
    );
  }
}
