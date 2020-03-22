import 'package:androidArchitecture/domain/TreeRepository.dart';
import 'package:androidArchitecture/domain/model/TreeState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'AnalyticsTracker.dart';
import 'UserDao.dart';

class ServiceLocator {
  static final instance = ServiceLocator();

  static final _userDao = UserDao(_tableNames);
  static final _analyticsTracker = AnalyticsTracker();

  final _treeStateDao = TreeStateDao(
      _userDao, _analyticsTracker, Firestore.instance, _tableNames);

  final _treeRepository = TreeDao(_userDao, _tableNames);

  getUserDao() => _userDao;
  getTreeStateDao() => _treeStateDao;
  getTreeDao() => _treeRepository;

  /// Returns true when using debug tables in firebase
  ///
  static isTableDebug() => true;
  static final _tableNames = isTableDebug() ? TableDebugNames() : TableNames();
  getTableNames() => _tableNames;
}

class TableNames {
  final leafDao = "leaf";
  final treeStateDao = "leaf_state";
  final treeStateProjectDao = "proj"; // this is nested inside treeStateDao
  final sectionDao = "section";

  final userDao = "user";
}

class TableDebugNames extends TableNames {
  final leafDao = "d_leaf";
  final treeStateDao = "d_leaf_state";
  final sectionDao = "d_section";
}
