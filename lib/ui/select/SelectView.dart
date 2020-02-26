import 'dart:convert';

import 'package:androidArchitecture/domain/model/OptionModel.dart';
import 'package:androidArchitecture/domain/model/TreeModel.dart';
import 'package:androidArchitecture/domain/model/SectionModel.dart';
import 'package:androidArchitecture/domain/model/TreeState.dart';
import 'package:androidArchitecture/landing/ColorPallete.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../serializers.dart';
import '../../domain/TreeRepository.dart';

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

  TreeState _treeState = TreeState.instance;

  _SelectViewState();

  @override
  void initState() {
    super.initState();

    TreeRepository().readModel(context).then((value) {
      setState(() {
        model = value.options.toList().first;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Wrap(
            spacing: 10,
            runSpacing: 20,
            children: model?.values
                    ?.toList()
                    ?.map(
                      (optionModel) => SelectButton(
                          _treeState.isSelected(optionModel.id),
                          optionModel.name,
                          optionModel.id, onPressed: () {
                        tapButton(optionModel.id);
                      }),
                    )
                    ?.toList() ??
                [],
          ),
        ),
        buildNavigation(),
      ],
    );
  }

  Widget buildNavigation() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          RaisedButton(
            child: Text("Previous"),
          ),
          Spacer(),
          RaisedButton(
            child: Text("Next"),
          ),
        ],
      ),
    );
  }

  void tapButton(String id) {
    debugPrint("Hello ");
    setState(() {
      _treeState.toggleSelectedState(id);
    });
  }
}

class SelectButton extends StatelessWidget {
  bool isSelected;
  String text;
  String id;

  VoidCallback onPressed;
  SelectButton(this.isSelected, this.text, this.id, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(text),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      )),
      color: getColor(),
      elevation: getElevation(),
      onPressed: () {
        this.onPressed();
      },
    );
  }

  Color getColor() {
    if (isSelected) {
      return ColorPallete.yellowLemon;
    } else {
      return ColorPallete.yellowCustard;
    }
  }

  double getElevation() {
    if (isSelected) {
      return 1;
    } else {
      return 4;
    }
  }
}
