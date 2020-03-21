import 'package:androidArchitecture/domain/ServiceLocator.dart';
import 'package:androidArchitecture/domain/UserDao.dart';
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
  final EditorRepository _editorRepository = EditorRepository.getInstance();
  final UserDao _userDao = ServiceLocator.instance.getUserDao();

  bool _isUserEditor = false;
  bool _isInEditMode = false;

  @override
  void initState() {
    super.initState();

    _editorRepository.getStream().listen((event) {
      setState(() {
        _isInEditMode = event;
      });
    });

    _userDao.getUserStream().listen((user) {
      debugPrint("User got here!!! ${user.isEditor} ${user.name} ${user.uid}");
      setState(() {
        _isUserEditor = user.isEditor;
        if (!_isUserEditor) {
          _isInEditMode = false;
        }
      });
    });
  }

  Widget build(BuildContext context) {
    if (!_isUserEditor) {
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
