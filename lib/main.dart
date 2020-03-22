import 'package:androidArchitecture/domain/FirebaseRepository.dart';
import 'package:androidArchitecture/ui/ColorPallete.dart';
import 'package:androidArchitecture/ui/landing/LandingView.dart';
import 'package:androidArchitecture/ui/editing/EditorSwitchView.dart';
import 'package:flutter/material.dart';

import 'score/ScoreView.dart';
import 'auth/LoginView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseRepository.getInstance().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Tree',
      theme: ColorPallete.of(context).getTheme(),
      home: MyHomePage(
        title: 'Tech Tree',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildToolbar(),
      body: LandingView(),
    );
  }

  Widget _buildToolbar() {
    return AppBar(
      title: Row(
        children: <Widget>[
          Text(widget.title),
          Expanded(child: Container()),
          ScoreView(),
          Expanded(child: Container()),
          EditorSwitchView(),
          LoginView(),
        ],
      ),
    );
  }
}
