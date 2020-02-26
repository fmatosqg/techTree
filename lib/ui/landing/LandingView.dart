import 'package:androidArchitecture/domain/editing/EditorRepository.dart';
import 'package:androidArchitecture/ui/select/SelectView.dart';
import 'package:androidArchitecture/select/BreadcrumbView.dart';
import 'package:flutter/cupertino.dart';

import '../editing/EditorView.dart';

class LandingView extends StatefulWidget {
  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  EditorRepository _editorRepository = EditorRepository.getInstance();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          _buildHeader(),
          Expanded(
            child: _buildContents(context),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  @override
  Widget _buildContents(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _editorRepository.getStream(),
        builder: (context, isInEditMode) {
          if (isInEditMode.data == true) {
            return _buildEditingView();
          } else {
            return _buildSelectionView();
          }
        });
  }

  Widget _buildEditingView() {
    return EditorView();
  }

  Widget _buildSelectionView() {
    return Center(
      child: Column(
        children: <Widget>[
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
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container();
  }

  Widget _buildFooter() {
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
