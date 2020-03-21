import 'package:androidArchitecture/domain/FirebaseRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
/// Adds UI that allows anonymous users to log in using a Google account.
///
///
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GoogleSignInAccount _currentUser;

  var _controller = LoginController();

  @override
  void initState() {
    super.initState();

    // TODO move into function in controller
    _controller._googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount account) {
      setState(() {
        if (account != null) {
          debugPrint("Current user is " + account.id);
        } else {
          debugPrint("Current user is now null");
        }
        _currentUser = account;
      });
    });

    _controller._googleSignIn.signInSilently().then((value) {
      if (value == null) {
        debugPrint("Anon user shoud log in");
        _controller._anonLogin();
      }
    });
  }

  Widget build(BuildContext context) {
    if (_currentUser != null) {
      return FlatButton(
        onPressed: _controller._handleSignOut,
        child: GoogleUserCircleAvatar(
          identity: _currentUser,
        ),
      );
    } else {
      return OutlineButton(
        child: const Text('LOG IN'),
        onPressed: _controller._handleSignIn,
      );
    }
  }
}

class LoginController {
  final _googleSignIn = FirebaseRepository.getInstance().googleSignIn;
  final _firebaseAuth = FirebaseRepository.getInstance().firebaseAuth;

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _firebaseAuth.signInWithCredential(credential)).user;
      debugPrint("signed in " + user.displayName);
    } catch (error) {
      debugPrint("Hello error 1 " + error.toString());
    }
  }

  Future<void> _handleSignOut() {
    _googleSignIn.disconnect();
    _firebaseAuth.signOut();
  }

  _anonLogin() {
    _firebaseAuth.signInAnonymously();
  }
}
