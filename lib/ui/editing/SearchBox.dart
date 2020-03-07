import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(20.0),
      child: TextField(
        maxLines: 100,
        minLines: 1,
        decoration: InputDecoration(
//          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: "Search keyword",
        ),
      ),
    );
  }
}
