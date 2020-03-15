import 'package:androidArchitecture/domain/editing/EditorRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Gets the UI into editing mode.
///
class EditorSwitchView extends StatefulWidget {
  @override
  _EditorSwitchViewState createState() => _EditorSwitchViewState();
}

class _EditorSwitchViewState extends State<EditorSwitchView> {
  EditorRepository _editorRepository = EditorRepository.getInstance();

  bool _isInEditMode = false;

  @override
  void initState() {
    super.initState();

    _editorRepository.getStream().listen((event) {
      setState(() {
        _isInEditMode = event;
      });
    });
  }

  Widget build(BuildContext context) {
    if (_isInEditMode == null) {
      return Container();
    }
    return Row(
      children: <Widget>[
        Switch(
          value: _isInEditMode,
          onChanged: (newValue) {
            _setEditMode(newValue);
          },
        ),
      ],
    );
  }

  void _setEditMode(bool newValue) {
    setState(() {
      _editorRepository.setEditorMode(newValue);
    });
  }
}
