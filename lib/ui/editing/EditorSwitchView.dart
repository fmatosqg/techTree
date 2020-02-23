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
  EditorRepository editorRepository = EditorRepository.getInstance();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: editorRepository.getStream(),
      builder: (context, isInEditMode) {
        return Row(
          children: <Widget>[
            Text("Editor"),
            Switch(
              value: isInEditMode.data ?? false,
              onChanged: (newValue) {
                setEditMode(newValue);
              },
            ),
          ],
        );
      },
    );
  }

  void setEditMode(bool newValue) {
    setState(() {
      editorRepository.setEditorMode(newValue);
    });
  }
}
