import 'package:firebase_analytics/firebase_analytics.dart';

/// Tracks domain events and send it to Firebase Analytics
///
class AnalyticsTracker {
  var _analytics = FirebaseAnalytics();

  static var _eventSection = "Section";
  static var _eventLeaf = "Leaf";

  static var _keyId = "id";
  static var _keyName = "name"; // new state of leaf selection
  static var _keyIsSelected = "selected"; // new state of leaf selection

  void sectionChange(String sectionId, String sectionName) {
    _analytics.logEvent(name: _eventSection, parameters: {
      _keyId: sectionId,
      _keyName: sectionName,
    });
  }

  void leafSelection(bool isSelected, String leafId, String leafName) {
    _analytics.logEvent(name: _eventLeaf, parameters: {
      _keyId: leafId,
      _keyName: leafName,
      _keyIsSelected: isSelected
    });
  }

  /// Logs an event with a single value
  _sendEvent(String eventName, String detailKey, String detailValue) {}
}
