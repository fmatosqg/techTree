import 'package:androidArchitecture/domain/AnalyticsTracker.dart';
import 'package:androidArchitecture/domain/FirebaseRepository.dart';
import 'package:androidArchitecture/domain/UserDao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

/// Holds the state of the selected buttons in the chosen tree
///
class TreeState {
  static var instance = TreeState();

  final _userDao = UserDao();

  final _analytics = AnalyticsTracker();
  final _stateMap = Map<String, dynamic>();

  var _init = false;

  TreeState() {
    _loadMap();
  }

  bool isSelected(String id) {
    debugPrint("Whole map $_stateMap");
    return _stateMap[id] ?? false;
  }

  /// flips state of selected id from true to false and vice versa
  ///
  void toggleSelectedState(String leafId, String leafName) {
    var newState = !(_stateMap[leafId] ?? false);

    if (newState == true) {
      _stateMap[leafId] = newState;
    } else {
      _stateMap.remove(leafId); // keep the map (and firestore) lean
    }
    _saveToFirestore(leafId, newState);

    _analytics.leafSelection(newState, leafId, leafName);
  }

  String _getLeafStateTableName() {
    return "leaf_state";
  }

  void _loadMap() {
    _userDao.getUserId().then((uid) {
      Firestore.instance
          .collection(_getLeafStateTableName())
          .document(uid)
          ?.snapshots()
          ?.first
          ?.then((value) {
        debugPrint("loading map $value - ${value.data.entries}");
        _stateMap.addAll(value.data);
        debugPrint("loading map ${value.data}");
        debugPrint("loading map 2 $_stateMap");
      });
    });
  }

  void _saveToFirestore(String leafId, bool newState) {
    _userDao.getUserId().then((uid) {
      Firestore.instance
          .collection(_getLeafStateTableName())
          .document(uid)
          .setData(_stateMap);
    });
  }
}
