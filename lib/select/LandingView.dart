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
    return Text("Header");
  }

  buildFooter() {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Color.fromARGB(255, 100, 100, 255),
      child: Row(
        children: <Widget>[
          Text(
            "Footer",
          ),
        ],
      ),
    );
  }
}
