import 'package:androidArchitecture/domain/TreeRepository.dart';
import 'package:androidArchitecture/domain/model/TreeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'SearchBox.dart';

class EditorView extends StatefulWidget {
  @override
  _EditorViewState createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  TreeRepository _treeRepository = TreeRepository();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: buildSectionList(),
        ),
        buildOptionList(),
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    SearchBox(),
                    Text("ID = hello"),
                    buildInputText("Friendly name"),
                    buildInputText("one"),
                    buildInputText("two"),
                  ],
                ),
              ),
              buildAddButton()
            ],
          ),
        ),
      ],
    );
  }

  buildInputText(String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLines: 100,
        minLines: 1,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: label,
        ),
      ),
    );
  }

  buildAddButton() {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          debugPrint("plus");
        },
      ),
    );
  }

  buildSectionList() {
    var tree = _treeRepository.readModel(context);

    return StreamBuilder<TreeModel>(
        stream: tree.asStream(),
        builder: (context, treeModel) {
          return ListView.builder(
            itemCount: treeModel?.data?.sections?.length ?? 0,
            itemBuilder: (context, index) {
              var model = treeModel.data.sections[index];

              return Text(model.name);
            },
          );
        });
  }

  buildOptionList() {
    return Container();
  }
}
