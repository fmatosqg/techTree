import 'package:androidArchitecture/landing/SelectView.dart';
import 'package:flutter/cupertino.dart';

class LandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          buildHeader(),
          Expanded(
            child: SelectView(),
          ),
          buildFooter(),
        ],
      ),
    );
  }

  buildHeader() {
    return Container();
  }

  buildFooter() {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Color.fromARGB(255, 100, 100, 255),
      child: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Version 0.0.1",
              ),
            ),
            Expanded(
              child: Text(""),
            ),
          ],
        ),
      ),
    );
  }
}
