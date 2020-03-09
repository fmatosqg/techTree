import 'package:androidArchitecture/domain/model/SectionModel.dart';
import 'package:androidArchitecture/domain/TreeRepository.dart';
import 'package:androidArchitecture/ui/ColorPallete.dart';
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

  @override
  void initState() {
    super.initState();

    TreeRepository().readModel(context).then((value) {
      setState(() {
        model = value.sections.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPallete.of(context).breadCrumbBackground,
      child: Column(
        children: model
                ?.toList()
                ?.map(
                  (section) => MaterialButton(
                    child: Text(section.name),
                    onPressed: () {
                      _navigateToSection(section.id);
                    },
                  ),
                )
                ?.toList() ??
            [],
      ),
    );
  }
}
