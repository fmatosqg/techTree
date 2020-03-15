import 'dart:async';

import 'package:androidArchitecture/domain/FirebaseRepository.dart';
import 'package:flutter/foundation.dart';

class EditorRepository {
  static EditorRepository _instance = EditorRepository();

  static EditorRepository getInstance() => _instance;

  StreamController<bool> _controller;

  Stream<bool> _stream;

  bool _lastValue;

  EditorRepository() {
    _controller = StreamController<bool>(sync: false);
    _stream = _controller.stream.asBroadcastStream();
    FirebaseRepository.getInstance()
        .firebaseAuth
        .onAuthStateChanged
        .listen((event) {
      // TODO check if user is admin and enable the editor toggle
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setEditorMode(null);

      // if in debug mode, enable editor switch to be visible and turn it on
      if (!kReleaseMode) {
        setEditorMode(true);
      }
    });
  }

  void setEditorMode(bool newValue) {
    _lastValue = newValue;
    _controller.add(newValue);
  }

  Stream<bool> getStream() {
    return _stream;
  }
}
