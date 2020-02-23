import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorPallete {
  static const pureGreen = Color(0xff00ff00);
  static const pureRed = Color(0xffff0000);
  static const yellowCustard = Color(0xffeedd77);
  static const yellowLemon = Color(0xffddff55);

  //////////////////
  static ColorPallete of(BuildContext context) {
    var selectViewSelectableButton = Theme.of(context)
        .buttonTheme
        .copyWith(buttonColor: pureGreen, disabledColor: pureRed);
  }
}
