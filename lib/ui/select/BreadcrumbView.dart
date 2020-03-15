import 'package:androidArchitecture/domain/FirebaseRepository.dart';
import 'package:androidArchitecture/domain/model/SectionModel.dart';
import 'package:androidArchitecture/domain/TreeRepository.dart';
import 'package:androidArchitecture/ui/ColorPallete.dart';
import 'package:androidArchitecture/ui/editing/EditorView.dart';
import 'package:androidArchitecture/ui/editing/TechTreeDocument.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The bar on the left of the selection view, where you can
/// navigate to different techs to select them.
///
class BreadCrumbView extends StatefulWidget {
  final Function(String sectionId) _navigateToSection;

  BreadCrumbView(this._navigateToSection);

  @override
  State<StatefulWidget> createState() => _BreadCrumbState(_navigateToSection);
}

class _BreadCrumbState extends State<BreadCrumbView> {
  List<SectionModel> model;

  Function(String sectionId) _navigateToSection;

  _BreadCrumbState(this._navigateToSection);

  final _treeRepository = TreeRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _treeRepository.getAllSections(),
        builder: (context, snapshop) {
          return _buildSections(snapshop.data);
        });
  }

  Widget _buildSections(Iterable<SectionDocument> sectionList) {
    return Container(
      color: ColorPallete.of(context).breadCrumbBackground,
      child: Column(
        children: sectionList?.toList()?.map(
              (section) {
                return _buildSectionButton(section);
              },
            )?.toList() ??
            [Container()],
      ),
    );
  }

  Widget _buildSectionButton(SectionDocument section) {
    return FlatButton(
      child: Text(section?.name ?? "empty"),
      onPressed: () {
        _navigateToSection(section?.id ?? "empty");
      },
    );
  }
}
