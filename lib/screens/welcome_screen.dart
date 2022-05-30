import 'package:flash_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import '../components/rounded_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = '/';

  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.lightBlue, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      if (kDebugMode) {
        print(controller.value);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation?.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height: 80,
                  ),
                ),
                AnimatedTextKit(animatedTexts: [
                  TypewriterAnimatedText(
                    'Flash Chat',
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ]),
              ],
            ),
            const SizedBox(height: 48.0),
            RoundedButton(
                text: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  WidgetsBinding.instance
                      ?.addPostFrameCallback((timeStamp) async {
                    Navigator.pushNamed(context, LoginScreen.id);
                  });
                }),
            RoundedButton(
                text: 'Register',
                color: Colors.blueAccent,
                onPressed: () {
                  WidgetsBinding.instance
                      ?.addPostFrameCallback((timeStamp) async {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  });
                }),
          ],
        ),
      ),
    );
  }
}
