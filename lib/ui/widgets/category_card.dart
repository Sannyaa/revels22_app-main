import 'package:animations/animations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mitrevels22/config/enums/enums.dart';

const delegateMap = {
  DelegateCardType.PROSHOW: 'PROSHOW',
  DelegateCardType.INF: 'INF',
  DelegateCardType.GAMING: 'GAMING',
  DelegateCardType.WORKSHOPS: 'WORKSHOPS',
  DelegateCardType.GENERAL: 'GENERAL',
  DelegateCardType.SPORTS: 'SPORTS'
};

/// A Neumorphic Card to display the Categories.
class CategoryCard extends StatelessWidget {
  /// The name of the Category.
  final String categoryName;

  /// The first color to paint the gradient.
  final Color color1;

  /// The second color to paint the gradient.
  final Color color2;
  final String cardId;
  final DelegateCardType type;
  const CategoryCard({
    Key? key,
    required this.categoryName,
    required this.type,
    required this.color1,
    required this.color2,
    required this.cardId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250 * 3 / 4,
      child: NeumorphicButton(
        padding: const EdgeInsets.all(0),
        onPressed: () => null,
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(18),
          ),
          border: NeumorphicBorder(color: color2),
        ),
        drawSurfaceAboveChild: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  categoryName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  delegateMap[type].toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  cardId.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
