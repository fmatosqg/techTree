import 'package:androidArchitecture/domain/ServiceLocator.dart';
import 'package:androidArchitecture/domain/TreeRepository.dart';
import 'package:androidArchitecture/ui/ColorPallete.dart';
import 'package:androidArchitecture/ui/editing/TechTreeDocument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The bar on the left of the selection view, where you can
/// navigate to different techs to select them.
///
class BreadCrumbView extends StatefulWidget {
  final Function(String sectionId, String name) _navigateToSection;

  BreadCrumbView(this._navigateToSection);

  @override
  State<StatefulWidget> createState() => _BreadCrumbState(_navigateToSection);
}

class _BreadCrumbState extends State<BreadCrumbView> {
  String _selectedSectionId;

  final _techId = TreeDao.TechIdAndroid;

  Function(String sectionId, String sectionName) _navigateToSection;

  _BreadCrumbState(this._navigateToSection);

  final _treeDao = ServiceLocator.instance.getTreeDao();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _treeDao.getAllSections(_techId),
        builder: (context, snapshop) {
          return _buildSections(context, snapshop.data);
        });
  }

  Widget _buildSections(
      BuildContext context, Iterable<SectionDocument> sectionList) {
    return Container(
      color: ColorPallete.of(context).breadCrumbBackground,
      child: Column(
        children: sectionList?.toList()?.map(
              (section) {
                return _buildSectionButton(context, section);
              },
            )?.toList() ??
            [Container()],
      ),
    );
  }

  Widget _buildSectionButton(BuildContext context, SectionDocument section) {
    return FlatButton(
      color: _getButtonColor(context, section.id),
      child: Text(section?.name ?? "empty"),
      onPressed: () {
        _navigateToSection(section?.id ?? "empty", section?.name);
        setState(() {
          _selectedSectionId = section.id;
        });
      },
    );
  }

  Color _getButtonColor(BuildContext context, String sectionId) {
    if (_selectedSectionId == sectionId) {
      return ColorPallete.of(context).breadCrumbHighlightedColor;
    } else {
      return Colors.transparent;
    }
  }
}
