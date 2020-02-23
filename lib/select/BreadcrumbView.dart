import 'package:androidArchitecture/domain/model/SectionModel.dart';
import 'package:androidArchitecture/domain/TreeRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BreadCrumbView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BreadCrumbState();
}

class _BreadCrumbState extends State<BreadCrumbView> {
  List<SectionModel> model;

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
      color: Color.fromARGB(255, 200, 230, 210),
      child: Column(
        children: model
                ?.toList()
                ?.map(
                  (section) => MaterialButton(
                    child: Text(section.name),
                    onPressed: () {
                      navigateToSection(section.id);
                    },
                  ),
                )
                ?.toList() ??
            [],
      ),
    );
  }

  navigateToSection(String sectionId) {}
}
