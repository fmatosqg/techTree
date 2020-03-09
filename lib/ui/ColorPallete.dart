import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorPallete {
  static const pureGreen = Color(0xff00ff00);
  static const pureRed = Color(0xffff0000);

  static const greenPistachio = Color(0xffc8e6d2); // 200 230 210

  static const yellowCustard = Color(0xffeedd77);
  static const yellowLemon = Color(0xffddff55);

  static const greenLime = Color(0xffb0b52b);
  static const greenLimeDark = Color(0xff7d8600);
  static const greenLimeLight = Color(0xffe5e75f);

  static const orange = Color(0xffffcc80);
  static const orangeDark = Color(0xffca9b52);
  static const orangeLight = Color(0xffffffb0);

  //////////////////
  static ColorPallete of(BuildContext context) {
    return ColorPallete(context);
  }

  ThemeData _themeData;

  ColorPallete(BuildContext context) {
    var parentTheme = Theme.of(context);

    _themeData = parentTheme.copyWith(
//      brightness: Brightness.dark,
      primaryColor: greenLime,
      primaryColorLight: greenLimeLight,
      primaryColorDark: greenLimeDark,
      accentColor: orange,
      buttonTheme: parentTheme.buttonTheme.copyWith(
        buttonColor: greenLime,
      ),
      toggleButtonsTheme: parentTheme.toggleButtonsTheme.copyWith(
          color: orange,
          highlightColor: orangeLight,
          hoverColor: orangeLight,
          selectedColor: orangeDark),
    );
  }

  final breadCrumbBackground = orangeDark;

  ThemeData getTheme() {
    return _themeData;
  }
}
