import 'package:androidArchitecture/domain/TreeRepository.dart';
import 'package:androidArchitecture/ui/ColorPallete.dart';
import 'package:androidArchitecture/ui/select/BreadcrumbView.dart';
import 'package:androidArchitecture/ui/select/SelectView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NewSectionView.dart';
import 'TechTreeDocument.dart';

class EditorView extends StatefulWidget {
  @override
  _EditorViewState createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  TreeRepository _treeRepository = TreeRepository();

  String _sectionId;

  var _isAddingNewSection = false;
  var _isAddingNewLeaf = false;

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
  /// Builds the plane that matches the view port, and is not meant for typing (editing/creating).
  ///
  /// It holds the breadcrumb on the left, and the tree leaves selection on the middle and right
  Widget _build2ndPlane(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
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
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      SelectView(_sectionId),
                      buildAddButton(_actionAddLeaf)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _navigateToSection(String sectionId, String sectionName) {
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

  _buildSectionPlane(BuildContext context) {
    if (_isAddingNewSection) {
      return NewSectionView(
          _actionDoneAddingSection, _actionSaveSectionDocument);
    } else if (_isAddingNewLeaf) {
      return NewLeafView(
          _sectionId, _actionDoneAddingLeaf, _actionSaveLeafDocument);
    } else {
      return Container();
    }
  }

  ////////////////////////////////////////////////
  // view listeners
  _actionAddSection() {
    setState(() {
      _isAddingNewSection = true;
    });
  }

  _actionDoneAddingSection() {
    setState(() {
      _isAddingNewSection = false;
    });
  }

  _actionAddLeaf() {
    setState(() {
      _isAddingNewLeaf = true;
    });
  }

  _actionDoneAddingLeaf() {
    setState(() {
      _isAddingNewLeaf = false;
    });
  }

  /// Saves document and closes modal when insertion is successfull
  ///
  /// - document: document to be saved
  /// - shouldStopEditing: if the modal should be dismissed after a successful save
  ///
  /// returns bool: true when document was saved successfully
  ///
  Future<bool> _actionSaveSectionDocument(
      bool shouldStopEditing, TechTreeDocument document) {
    return _actionSaveDocument(
        shouldStopEditing, () => _treeRepository.saveSectionDocument(document));
  }

  Future<bool> _actionSaveLeafDocument(
      bool shouldStopEditing, TechTreeDocument document) {
    return _actionSaveDocument(
        shouldStopEditing, () => _treeRepository.saveLeafDocument(document));
  }

  Future<bool> _actionSaveDocument(
      bool shouldStopEditing, Future<bool> Function() saveDocument) {
    var isSuccess = saveDocument();

    isSuccess.then((value) {
      if (value && shouldStopEditing) {
        _actionDoneAddingSection();
      }
    });

    return isSuccess;
  }
}
