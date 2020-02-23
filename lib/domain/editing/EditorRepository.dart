import 'dart:async';

import 'package:flutter/cupertino.dart';

class EditorRepository {
  static EditorRepository _instance = EditorRepository();

  static EditorRepository getInstance() => _instance;

  StreamController<bool> _controller;

  Stream<bool> _stream;

  EditorRepository() {
    _controller = StreamController();
    _stream = _controller.stream.asBroadcastStream();
  }

  void setEditorMode(bool newValue) {
    debugPrint("new value $newValue");
    _controller.add(newValue);
  }

  Stream<bool> getStream() {
    return _stream;
  }
}