import 'package:androidArchitecture/domain/editing/EditorRepository.dart';
import 'package:androidArchitecture/landing/SelectView.dart';
import 'package:androidArchitecture/select/BreadcrumbView.dart';
import 'package:flutter/cupertino.dart';

class LandingView extends StatefulWidget {
  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  EditorRepository _editorRepository = EditorRepository.getInstance();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _editorRepository.getStream(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return buildEditingView();
          } else {
            return buildSelectionView();
          }
        });
  }

  Widget buildEditingView() {
    return Text("Edit");
  }

  Widget buildSelectionView() {
    return Center(
      child: Column(
        children: <Widget>[
          buildHeader(),
          Expanded(
            child: Row(
              children: <Widget>[
                BreadCrumbView(),
                Expanded(
                  child: SelectView(),
                ),
              ],
            ),
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
