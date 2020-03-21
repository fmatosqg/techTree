import 'package:androidArchitecture/domain/ServiceLocator.dart';
import 'package:androidArchitecture/domain/model/TreeState.dart';
import 'package:androidArchitecture/ui/ColorPallete.dart';
import 'package:androidArchitecture/ui/editing/TechTreeDocument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/TreeRepository.dart';

/// Allows the user to select among a list of choices.
///
class SelectView extends StatefulWidget {
  final String sectionId;

  final _SelectViewState _state = _SelectViewState();

  SelectView(this.sectionId);

  @override
  State<StatefulWidget> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  TreeDao _treeRepository = ServiceLocator.instance.getTreeDao();
  TreeStateDao _treeState = ServiceLocator.instance.getTreeStateDao();

  _SelectViewState();

  Widget buildNavigation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          RaisedButton(
            child: Text("Previous"),
            onPressed: () {},
          ),
          Spacer(),
          RaisedButton(
            child: Text("Next"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void tapButton(String sectionId, String sectionName) {
    debugPrint("Hello ");
    setState(() {
      _treeState.toggleSelectedState(sectionId, sectionName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<LeafDocument>>(
        stream: _treeRepository.getLeafList(widget.sectionId),
        builder: (context, snapshop) {
          return _buildLeaves(snapshop.data);
        });
  }

  Widget _buildLeaves(Iterable<LeafDocument> sectionList) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Wrap(
        spacing: 10,
        runSpacing: 20,
        children: sectionList?.toList()?.map(
              (leaf) {
                return SelectButton(
                    _treeState.isSelected(leaf.id), leaf.name, leaf.id,
                    onPressed: () {
                  tapButton(leaf.id, leaf.name);
                });
              },
            )?.toList() ??
            [Container()],
      ),
    );
  }
}

/// Represents a particular node on the tech tree, which can be selected or disabled.
///
class SelectButton extends StatelessWidget {
  bool isSelected;
  String text;
  String id;

  VoidCallback onPressed;
  SelectButton(this.isSelected, this.text, this.id, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text ?? "",
          textScaleFactor: 1.3,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      color: getColor(context),
      elevation: getElevation(),
      onPressed: () {
        this.onPressed();
      },
    );
  }

  Color getColor(BuildContext context) {
    if (isSelected) {
      return ColorPallete.of(context)
          .getTheme()
          .toggleButtonsTheme
          .selectedColor;
    } else {
      return ColorPallete.of(context).getTheme().toggleButtonsTheme.color;
    }
  }

  double getElevation() {
    if (isSelected) {
      return 1;
    } else {
      return 4;
    }
  }
}
