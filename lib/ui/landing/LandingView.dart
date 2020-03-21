import 'package:androidArchitecture/auth/LoginView.dart';
import 'package:androidArchitecture/domain/AnalyticsTracker.dart';
import 'package:androidArchitecture/domain/editing/EditorRepository.dart';
import 'package:androidArchitecture/ui/ColorPallete.dart';
import 'package:androidArchitecture/ui/editing/EditorView.dart';
import 'package:androidArchitecture/ui/select/BreadcrumbView.dart';
import 'package:androidArchitecture/ui/select/SelectView.dart';
import 'package:flutter/cupertino.dart';

class LandingView extends StatefulWidget {
  var _analytics = AnalyticsTracker();

  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  EditorRepository _editorRepository = EditorRepository.getInstance();

  String _sectionId;

  _navigateToSection(String sectionId, String sectionName) {
    widget._analytics.sectionChange(sectionId, sectionName);

    setState(() {
      _sectionId = sectionId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          _buildHeader(),
          Expanded(
            child: _buildContents(context),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

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
                BreadCrumbView(_navigateToSection),
                Expanded(
                  child: SelectView(_sectionId),
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

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: ColorPallete.of(context).getTheme().primaryColor,
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
