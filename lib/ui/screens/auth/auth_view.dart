import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mitrevels22/logic/router.dart';

class AuthView extends StatelessWidget {
  final RevelsAppState appState;
  const AuthView({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: Positioned(
                      top: -30,
                      left: -25,
                      child: Image.asset(
                        'assets/darklogo.png',
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: NeumorphicButton(
                onPressed: () {
                  appState.authPage = AuthPages.login;
                },
                padding: const EdgeInsets.all(16.0),
                style: const NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.stadium(),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                    'LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF70C2BC),
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: NeumorphicButton(
                onPressed: () {
                  appState.authPage = AuthPages.signup;
                },
                padding: const EdgeInsets.all(16.0),
                style: const NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.stadium(),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                    'REGISTER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8C9ED9),
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
