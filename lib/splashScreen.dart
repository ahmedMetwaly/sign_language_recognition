import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sign_language_detector/TalkerOrDeaf.dart';
class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {

    return SplashScreen(
      gradientBackground: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF681006),Color(0xFF1E0003)],
      ),
      loaderColor: Color(0xFFDF994E),
      seconds: 3,
      navigateAfterSeconds: SpeachOrListen(),
      image: Image.asset('assets/deaf-man-emoji-clipart-xl.png'),
      photoSize: 150,
      title: Text('التعرف على لغة الإشارة العربية',
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Color(0xFFDAA520)
        ),),
    );
  }
}
