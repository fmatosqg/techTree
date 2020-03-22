import 'dart:async';
import 'dart:html';

import 'package:androidArchitecture/domain/AnalyticsTracker.dart';
import 'package:androidArchitecture/domain/FirebaseRepository.dart';
import 'package:androidArchitecture/domain/UserDao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../ServiceLocator.dart';
import '../TreeRepository.dart';

/// Holds the state of the selected buttons in the chosen tree
///
class TreeStateDao {
  final UserDao _userDao;
  final AnalyticsTracker _analytics;
  final Firestore _firestore;
  final TableNames _tableNames;

  final _stateMap = Map<String, dynamic>();
  final _streamCount = StreamController<int>();

  var _init = false;

  TreeStateDao(
      this._userDao, this._analytics, this._firestore, this._tableNames) {
    _streamCount.add(0);
    _loadMap();
  }

  bool isSelected(String id) {
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
//    debugPrint("Whole map $_stateMap");
    _saveToFirestore(leafId, newState);

    _streamCount.add(_stateMap.length);

    _analytics.leafSelection(newState, leafId, leafName);
  }

  void _loadMap() {
    _userDao.getUserId().then((uid) {
      debugPrint("Get userr $uid");
      _firestore
          .collection(_tableNames.treeStateDao)
          .document(uid)
          .collection(_tableNames.treeStateProjectDao)
          .document(TreeDao.DefaultProj)
          ?.snapshots()
          ?.first
          ?.then((value) {
//        debugPrint("loading map $value - ${value.data.entries}");
        _stateMap.addAll(value.data);
        _streamCount.add(_stateMap.length);
        debugPrint("loading map 22 $_stateMap");
      });
    });
  }

  void _saveToFirestore(String leafId, bool newState) {
    _userDao.getUserId().then((uid) {
      _firestore.collection(_tableNames.treeStateDao).document(uid).setData({});

      _firestore
          .collection(_tableNames.treeStateDao)
          .document(uid)
          .collection(_tableNames.treeStateProjectDao)
          .document(TreeDao.DefaultProj)
          .setData(_stateMap);
    });
  }

  Stream<int> getScoreStream() {
    return _streamCount.stream;
  }
}
