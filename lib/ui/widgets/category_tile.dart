import 'package:animations/animations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/data/models/category_model.dart';
import 'package:mitrevels22/logic/router.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final Color categoryGradientOne;
  final Color categoryGradientTwo;
  final RevelsAppState appState;

  const CategoryTile({
    Key? key,
    required this.category,
    required this.categoryGradientOne,
    required this.categoryGradientTwo,
    required this.appState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      padding: const EdgeInsets.all(8.0),
      minDistance: -4,
      onPressed: () => showModal(
        useRootNavigator: false,
        context: context,
        builder: (context) => SimpleDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          backgroundColor: const Color(0xFF21242B),
          contentPadding: const EdgeInsets.all(24),
          title: Text(
            category.category,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          children: [
            Text(
              category.description,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Check out the Events",
                    style: TextStyle(
                      color: categoryGradientTwo,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  NeumorphicButton(
                    minDistance: -4,
                    style: const NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      appState.homePage = HomePages.events;
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      color: categoryGradientTwo,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(8),
        ),
      ),
      child: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: <Color>[
              categoryGradientOne,
              categoryGradientTwo,
            ],
          ).createShader(bounds),
          child: Text(
            category.category,
            style: GoogleFonts.cabin(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
