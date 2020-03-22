import 'package:androidArchitecture/domain/ServiceLocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreView extends StatelessWidget {
  final _treeStateDao = ServiceLocator.instance.getTreeStateDao();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<int>(
          stream: _treeStateDao.getScoreStream(),
          builder: (context, snapshot) {
//            return Text("Score ${snapshot.data} ");
            return Row(
              children: <Widget>[
                Text("${snapshot.data} "),
                Icon(Icons.free_breakfast),
              ],
            );
          }),
    );
  }
}
