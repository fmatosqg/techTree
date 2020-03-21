import 'package:androidArchitecture/domain/AnalyticsTracker.dart';
import 'package:androidArchitecture/domain/FirebaseRepository.dart';
import 'package:androidArchitecture/domain/UserDao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../ServiceLocator.dart';

/// Holds the state of the selected buttons in the chosen tree
///
class TreeStateDao {
  final UserDao _userDao;
  final AnalyticsTracker _analytics;
  final Firestore _firestore;
  final TableNames _tableNames;

  final _stateMap = Map<String, dynamic>();

  var _init = false;

  TreeStateDao(
      this._userDao, this._analytics, this._firestore, this._tableNames) {
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

  void _loadMap() {
    _userDao.getUserId().then((uid) {
      debugPrint("Get userr $uid");
      _firestore
          .collection(_tableNames.treeStateDao)
          .document(uid)
          ?.snapshots()
          ?.first
          ?.then((value) {
        debugPrint("loading map $value - ${value.data.entries}");
        _stateMap.addAll(value.data);
        debugPrint("loading map 22 $_stateMap");
      });
    });
  }

  void _saveToFirestore(String leafId, bool newState) {
    _userDao.getUserId().then((uid) {
      _firestore
          .collection(_tableNames.treeStateDao)
          .document(uid)
          .setData(_stateMap);
    });
  }
}
