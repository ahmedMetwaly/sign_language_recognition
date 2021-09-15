import 'package:flutter/material.dart';
import 'package:sign_language_detector/splashScreen.dart';

void main(){

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Language Detector ',
      home: splashScreen(),
    );
  }
}