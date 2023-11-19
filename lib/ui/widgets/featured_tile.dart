import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/logic/router.dart';

class FeaturedTile extends StatelessWidget {
  final bool fullWidth;
  final String eventTitle;
  final String eventCategory;
  final Color categoryGradientOne;
  final Color categoryGradientTwo;
  final RevelsAppState appState;
  final Color eventColor;
  const FeaturedTile({
    Key? key,
    required this.fullWidth,
    required this.eventTitle,
    required this.eventCategory,
    required this.categoryGradientOne,
    required this.categoryGradientTwo,
    required this.eventColor,
    required this.appState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        categoryGradientOne,
        categoryGradientTwo,
      ],
    ).createShader(
      const Rect.fromLTWH(10.0, 0.0, 20.0, 0.0),
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: height * 0.16,
        width: fullWidth ? width * 0.9 : width * 0.4,
        child: NeumorphicButton(
          padding: const EdgeInsets.all(10.0),
          onPressed: () {
            appState.homePage = HomePages.events;
          },
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            depth: 4,
            shadowDarkColor: Colors.black,
            shadowLightColor: Color(0xFF454954),
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(8),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: eventColor,
                width: 0.8,
              ),
            ),
            child: Column(
              children: [
                const Align(
                  //add font awesome icon
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                      child: Image(
                        image: AssetImage('assets/christmas-stars.png'),
                      )),
                ),
                Text(
                  eventTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cabin(
                    fontSize: 18,
                    foreground: Paint()..shader = linearGradient,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  eventCategory.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
