import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Allows the user to select among a list of choices.
///
class SelectView extends StatelessWidget {
  SelectModel model;

  SelectView() {
    model = SelectModel();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 20,
      children: model.optionList
          .map(
            (optionModel) => RaisedButton(
              child: Text(optionModel.name),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              )),
              disabledColor: Color.fromARGB(255, 100, 100, 00),
              color: Color.fromARGB(255, 100, 100, 200),
              onPressed: () {
                debugPrint("Hello $optionModel");
              },
            ),
          )
          .toList(),
    );
  }
}

class SelectModel {
  String title;
  List<SelectOptionModel> optionList;

  SelectModel() {
    optionList = [
      SelectOptionModel("One"),
      SelectOptionModel("One"),
      SelectOptionModel("One"),
      SelectOptionModel("One"),
      SelectOptionModel("One"),
      SelectOptionModel("One"),
      SelectOptionModel("One"),
      SelectOptionModel("One"),
      SelectOptionModel("One"),
      SelectOptionModel("One"),
    ];
  }
}

class SelectOptionModel {
  String name;
  String description;
  String officialUrl;

  SelectOptionModel(this.name);
}
