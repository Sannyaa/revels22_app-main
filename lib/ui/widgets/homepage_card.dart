import 'package:flutter_neumorphic/flutter_neumorphic.dart';

/// Card used on the HomePage to display various sections of the app.
class HomePageCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final Widget page;
  const HomePageCard({
    Key? key,
    required this.image,
    required this.subtitle,
    required this.title,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: const NeumorphicStyle(
        depth: 0,
        boxShape: NeumorphicBoxShape.stadium(),
      ),
      minDistance: -4,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ],
          ),
          Neumorphic(
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              image,
              height: 48,
              width: 48,
            ),
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
          )
        ],
      ),
    );
  }
}
