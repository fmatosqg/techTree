import 'package:flutter/material.dart';

import '../ColorPallete.dart';
import 'TechTreeDocument.dart';

/// Opens a modal where you can type the name of a new section.
///
///
class NewSectionView extends StatelessWidget {
  Function _actionClose;

  ModalSaveAction _actionSaveDocument;

  Map<String, TextEditingController> controllerMap = Map();

  NewSectionView(this._actionClose, this._actionSaveDocument);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorPallete.of(context).modalBackground,
      child: Align(
        alignment: Alignment.center,
        child: Wrap(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(32.0),
              child: Container(
                margin: const EdgeInsets.all(32.0),
                child: Wrap(children: buildForm(context)),
              ),
              elevation: 4,
            ),
          ],
        ),
      ),
    );
    ;
  }

  Map<String, String> getInputIds() {
    return {
      'name': 'New section name',
//      'a': 'aaa aaa',
    };
  }

  List<Widget> buildForm(BuildContext context) {
    controllerMap.clear();

    var firstFocusNode = FocusNode();

    FocusScope.of(context).requestFocus(firstFocusNode);

    var firstKey = getInputIds().entries.first.key;

    return getInputIds()
        .entries
        .map(
          (e) => _buildInputText(context,
              e.key == firstKey ? firstFocusNode : null, e.key, e.value),
        )
        .toList()
          ..insert(0, _buildCloseButton())
          ..add(_buildSaveButton(context));
  }

  Widget _buildInputText(
      BuildContext context, FocusNode focusNode, String key, String value) {
    var controller =
        controllerMap.putIfAbsent(key, () => TextEditingController());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        focusNode: focusNode,
        autofocus: true,
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

  Widget _buildSaveButton(BuildContext context) {
    return Wrap(
      spacing: 32,
      children: <Widget>[
        RaisedButton(
          child: Text("Save and create next"),
          onPressed: () {
            var document = getDocumentFromControllers(controllerMap);
            _actionSaveDocument(false, document).then((isInsertSuccessful) {
              if (isInsertSuccessful) {
                controllerMap.forEach((key, value) {
                  value.text = "";
                });

                _buildFeedback(context, "Insert successfull");
              } else {
                _buildFeedback(context, "Insert failed");
              }
            });
          },
        ),
        RaisedButton(
          child: Text("Save and stop"),
          onPressed: () {
            _actionSaveDocument(true, getDocumentFromControllers(controllerMap))
                .then((value) => null);
          },
        ),
      ],
    );
  }

  void _buildFeedback(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  TechTreeDocument getDocumentFromControllers(
      Map<String, TextEditingController> controllerMap) {
    return SectionDocument(name: controllerMap["name"].text);
  }
}

class NewLeafView extends NewSectionView {
  String _sectionId;

  NewLeafView(
      this._sectionId, Function actionClose, Function actionSaveDocument)
      : super(actionClose, actionSaveDocument);

  Map<String, String> getInputIds() {
    return {'name': 'New tech name'};
  }

  TechTreeDocument getDocumentFromControllers(
      Map<String, TextEditingController> controllerMap) {
    return LeafDocument(
        sectionId: _sectionId, name: controllerMap["name"].text);
  }

  @override
  List<Widget> buildForm(BuildContext context) {
    return super.buildForm(context)
      ..insert(
        1,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text("Section: $_sectionId"),
        ),
      );
  }
}

typedef ModalSaveAction = Future<bool> Function(
    bool shouldStopEditing, TechTreeDocument document);
