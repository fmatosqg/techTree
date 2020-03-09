import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
/// Adds UI that allows anonymous users to log in using a Google account.
///
/// Documentation for web: https://pub.dev/packages/google_sign_in_web
/// Go to https://console.developers.google.com/apis/credentials for configuration.
/// Be sure to match the localhost port you find over there in OAUTH 2.0 edit and
/// when running debug builds (`flutter run -d chrome --web-hostname localhost --web-port 5000`)
///
/// Then to actually sign in either open a fresh chrome window not launched by flutter or
/// See more details at https://stackoverflow.com/questions/59480956/browser-or-app-may-not-be-secure-try-using-a-different-browser-error-with-fl
///
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
//    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class _LoginViewState extends State<LoginView> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });

    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      debugPrint(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget build(BuildContext context) {
    if (_currentUser != null) {
      return FlatButton(
        onPressed: _handleSignOut,
        child: GoogleUserCircleAvatar(
          identity: _currentUser,
        ),
      );
    } else {
      return OutlineButton(
        child: const Text('LOG IN'),
        onPressed: _handleSignIn,
      );
    }
  }
}
