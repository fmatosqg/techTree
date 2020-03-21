import 'package:androidArchitecture/domain/AnalyticsTracker.dart';

/// Holds the state of the selected buttons in the chosen tree
///
/// TODO reimplement this with firebase
class TreeState {
  static var instance = TreeState();

  var _analytics = AnalyticsTracker();
  var _stateMap = Map<String, bool>();

  bool isSelected(String id) {
    return _stateMap[id] ?? false;
  }

  /// flips state of selected id from true to false and vice versa
  ///
  /// Returns the new value
  bool toggleSelectedState(String leafId, String leafName) {
    var newState = !(_stateMap[leafId] ?? false);

    _stateMap[leafId] = newState;

    _analytics.leafSelection(newState, leafId, leafName);
  }
}
