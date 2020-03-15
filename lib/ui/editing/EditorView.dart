import 'package:androidArchitecture/domain/TreeRepository.dart';
import 'package:androidArchitecture/domain/model/TreeModel.dart';
import 'package:androidArchitecture/ui/ColorPallete.dart';
import 'package:androidArchitecture/ui/select/BreadcrumbView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TechTreeDocument.dart';

class EditorView extends StatefulWidget {
  @override
  _EditorViewState createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  TreeRepository _treeRepository = TreeRepository();

  String _sectionId;

  var _isAddingNewSection = false;

  ///
  /// Builds on a stack the 1st plane (adding new section/leaf) and
  /// also 2nd plane (see what's already in db)
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _build2ndPlane(context),
        _buildSectionPlane(context),
      ],
    );
  }

  ///
  /// Builds the plane that matches the view port, and is not meant for typing
  Widget _build2ndPlane(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Stack(
            children: [
              BreadCrumbView(_navigateToSection),
              buildAddButton(_actionAddSection),
            ],
          ),
        ),
      ],
    );
  }

  _navigateToSection(String sectionId) {
    debugPrint("Section id is $sectionId");
    setState(() {
      _sectionId = sectionId;
    });
  }

  buildAddButton(Function _action) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: _action,
      ),
    );
  }

  buildSectionList() {
    var tree = _treeRepository.readModel(context);

    return StreamBuilder<TreeModel>(
        stream: tree.asStream(),
        builder: (context, treeModel) {
          return ListView.builder(
            itemCount: treeModel?.data?.sections?.length ?? 0,
            itemBuilder: (context, index) {
              var model = treeModel.data.sections[index];

              return Text(model.name);
            },
          );
        });
  }

  buildOptionList() {
    return Container();
  }

  _buildSectionPlane(BuildContext context) {
    if (_isAddingNewSection) {
      return NewSection(_actionDoneAddingSection, _actionSaveDocument);
    } else {
      return Container();
    }
  }

  ////////////////////////////////////////////////
  // view listeners
  _actionAddSection() {
    debugPrint("add section plus");
    setState(() {
      _isAddingNewSection = true;
    });
  }

  _actionDoneAddingSection() {
    setState(() {
      _isAddingNewSection = false;
    });
  }

  /// Saves document and closes modal when insertion is successfull
  _actionSaveDocument(TechTreeDocument document) {
    _treeRepository.saveDocument(document).then((isInsertSuccessfull) {
      if (isInsertSuccessfull) {
        _actionDoneAddingSection();
      } else {
        // TODO show error message
      }
    });
  }
}

class NewSection extends StatelessWidget {
  Function _actionClose;
  Function _actionSaveDocument;

  Map<String, TextEditingController> controllerMap = Map();

  NewSection(this._actionClose, this._actionSaveDocument);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorPallete.of(context).modalBackground,
      child: Wrap(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(32.0),
            child: Container(
              margin: const EdgeInsets.all(32.0),
              child: Wrap(children: _buildForm()),
            ),
            elevation: 4,
          ),
        ],
      ),
    );
    ;
  }

  List<Widget> _buildForm() {
    var map = {'name': 'New section name'};

    List<String> keyList = ["name"];

    controllerMap.clear();

    return map.entries
        .map(
          (e) => _buildInputText(e.key, e.value),
        )
        .toList()
          ..insert(0, _buildCloseButton())
          ..add(_buildSaveButton());
  }

  Widget _buildInputText(String key, String value) {
    var controller =
        controllerMap.putIfAbsent(key, () => TextEditingController());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        maxLines: 100,
        minLines: 1,
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: value,
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Container(
      alignment: Alignment.topLeft,
// TODO use proper navigation and CloseButton
//      child: CloseButton(),
      child: IconButton(
        icon: Icon(Icons.close),
        onPressed: _actionClose,
      ),
    );
  }

  Widget _buildSaveButton() {
    return RaisedButton(
      child: Text("Save"),
      onPressed: () {
        _actionSaveDocument(_getSectionDocument(controllerMap));
      },
    );
  }

  TechTreeDocument _getSectionDocument(
      Map<String, TextEditingController> controllerMap) {
    return SectionDocument(name: controllerMap["name"].text);
  }
}
