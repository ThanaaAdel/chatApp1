import 'package:chat_project/HexColor.dart';
import 'package:flutter/material.dart';


class AppColors {
  static Color primary = const Color(0xff857854);
  static Color scaffoldColor = const Color(0xffF7F7F8);
  static Color optionColor = const Color(0xffFFA2A2);
  static Color greyColor = const Color(0xff667178);
  static Color pink = HexColor("#f53d6b");
  static Color darkOrange = HexColor("#8A6100");
  static Color zety = HexColor("#35685F");
  static Color progressColor = HexColor("#35685F");
  static Color notActiveBottom = HexColor("#afafaf");
  static Color yellow = HexColor("#FFF9EB");
  static Color blackTitle = const Color(0xff00080C);
  static Color blackTitle2 = const Color(0xff121311);
  static Color green = HexColor("#17663A");
  static Color greenLight = HexColor("#EEFBF4");
  static Color greyDivider = HexColor("#D8DDE0");
  static Color hintGreyColor = const Color(0xffC4C8CB);
  static Color redBorder = const Color(0xffF53D6B);
  static Color dividorColor = const Color(0xffE6EBEE);
  static Color detailsGreyColor = const Color(0xff565A5D);
  static Color yesButtonColor = const Color(0xff35685F);
  static Color successButtonColor = const Color(0xff25343E);
  static Color notStartColor = const Color(0xff44484A);
  static Color needUpdateColor = const Color(0xffFF8383);

//!
  static Color samawy = Color(0xff6C3494);
  static Color tempPrimary = Color(0xff6C3494);
  static Color primary2 = Color(0xffC93336);
  static Color secondPrimary = HexColor("#EAE0CF");
  static Color greyTextColor = const Color(0xff6F6F6F);

  static Color red = HexColor('#C05E5E');
  static Color grey = HexColor('#9EA3A5');
  static Color black = HexColor("#00080C");
  static Color blackLite = const Color(0xffEEEEEE);
  static Color blackTxt = HexColor("#565A5D");
  static Color greyLight = HexColor("#F7F7F8");
  static Color success = Colors.green;
  static Color lightWhite = Colors.green;
  static Color white = Colors.white;
  static Color lightWhite2 = Colors.white;
  static Color blue = Colors.blue;
  static Color redPrimary = Colors.red;
  static Color error = Colors.red;
  static Color transparent = Colors.transparent;

  static Color gray = Colors.grey;
  static Color grey1 = Colors.grey;
  static Color unselectedTabColor = Colors.grey;

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lightens(String color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(HexColor(color));
    final hslLight =
    hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
