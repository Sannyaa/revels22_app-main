import 'package:flutter_neumorphic/flutter_neumorphic.dart';

//Categories constants

List<dynamic> categoryColors = [
  {
    "color1": const Color(0xFFC27B07),
    "color2": const Color(0xFFFADC50),
  },
  {
    "color1": const Color(0xFF583DE3),
    "color2": const Color(0xFF0DAFF7),
  },
  {
    "color1": const Color(0xFFFE580C),
    "color2": const Color(0xFFD22CD8),
  },
  {
    "color1": const Color(0xFF11886F),
    "color2": const Color(0xFF23F1C3),
  },
];

//Faq constants

const Color bgColor = Color.fromRGBO(33, 36, 43, 1);

const List<Color> shadesBgColor = [
  Color(0xFF172E34),
  Color(0xFF102125),
  Color(0xFF060D0F),
  Color(0xFF030607),
  Color(0xFF000000),
];

const Color tileBgColor = Color.fromARGB(255, 55, 60, 72);
const Color expandedTileColor = Color.fromARGB(255, 111, 121, 141);
const Color stackTileColor = Color.fromARGB(255, 125, 134, 155);

const List<Color> tintsBgColor = [
  Color(0xFF37545D),
  Color(0xFF798d93),
  Color(0xFFA6B3B7),
  Color(0xFFE8ECED),
  Color(0xFFFFFFFF),
];

final depressedNeumorphicEffect = NeumorphicStyle(
  depth: -2,
  intensity: 0.5,
  color: bgColor,
  shadowDarkColor: shadesBgColor[2],
  shadowLightColor: tintsBgColor[0],
  shadowLightColorEmboss: shadesBgColor[1],
  shadowDarkColorEmboss: shadesBgColor[3],
);

const elevatedNeumorphicEffect = NeumorphicStyle(
  color: bgColor,
  lightSource: LightSource.topLeft,
  intensity: 1,
  depth: 3,
  shadowDarkColor: Color.fromRGBO(69, 73, 84, 0.2),
  shadowLightColor: Color.fromRGBO(0, 0, 0, 0.4),
);

const List<Color> delegateCardColors = [
  Color(0xffE9436F),
  Color(0xffFADC50),
  Color(0xff3EBFF9),
  Color(0xff16B694),
  Color(0xffA456DE),
];
