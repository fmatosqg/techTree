/// Holds the state of the selected buttons in the chosen tree
///
class TreeState {
  static var instance = TreeState();

  var stateMap = Map<String, bool>();

  var s = true;
  bool isSelected(String id) {
    return stateMap[id] ?? false;
  }

  void toggleSelectedState(String id) {
    stateMap[id] = !(stateMap[id] ?? false);
  }
}
