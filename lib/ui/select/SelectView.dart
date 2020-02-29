import 'package:androidArchitecture/domain/model/OptionModel.dart';
import 'package:androidArchitecture/domain/model/SectionModel.dart';
import 'package:androidArchitecture/domain/model/TreeState.dart';
import 'package:androidArchitecture/ui/ColorPallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/TreeRepository.dart';

/// Allows the user to select among a list of choices.
///
class SelectView extends StatefulWidget {
  final String sectionId;

  final _SelectViewState _state = _SelectViewState();

//  SelectView(String sectionId) {
  SelectView(this.sectionId) {
    debugPrint("Create selectview with id $sectionId");
//    _state.setId(sectionId);
  }

  @override
  State<StatefulWidget> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  OptionListModel model;

  SectionModel _section;

  TreeState _treeState = TreeState.instance;

  _SelectViewState() {
    debugPrint("_SelectViewState");
  }

  @override
  void didUpdateWidget(SelectView oldWidget) {
    debugPrint("did update state xxx ${widget.sectionId}");
    super.didUpdateWidget(oldWidget);
    setId(widget.sectionId);
  }

  void setId(String sectionId) {
    getSectionFromId(sectionId).then((newModel) {
      setState(() {
        debugPrint("new model is $newModel");
        model = newModel;
      });
    });
  }

  Future<OptionListModel> getSectionFromId(String sectionId) async {
    var model = await TreeRepository().readModel(context);

    var options = model.options.firstWhere((option) {
      return option.sectionId == sectionId;
    });

    return options;
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
