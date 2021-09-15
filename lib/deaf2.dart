import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_language_detector/constants.dart';
import 'package:url_launcher/url_launcher.dart';

const _url = 'https://arabic-sign-language.herokuapp.com/';

class Deaf2 extends StatefulWidget {
  const Deaf2({Key key}) : super(key: key);

  @override
  _Deaf2State createState() => _Deaf2State();
}

class _Deaf2State extends State<Deaf2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: buildAppBar(context),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF681006), Color(0xFF1E0003)],
            ),
          ),
          child: Center(
            child: Container(
              width:  MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(25),
              child: TextButton(
                child: Text(
                  'ابدأ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                onPressed: () => _launchURL(),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFFE99600),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
