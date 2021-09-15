import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:sign_language_detector/showVideo.dart';
import 'package:sign_language_detector/constants.dart';

class Talker extends StatefulWidget {
  @override
  _TalkerState createState() => _TalkerState();
}

class _TalkerState extends State<Talker> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 10000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String klma = '';
  String vid = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  int resultListened = 0;
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));
    if (hasSpeech) {
      _currentLocaleId = "ar_EG";
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: buildAppBar(context),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: buildFloatingButton(),

        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF681006), Color(0xFF1E0003)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'اضغط على الميكروفون قبل التحدث',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFFE99600),
                        fontWeight: FontWeight.w700,
                        fontSize: 26),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Text(
                    lastError != '' ? lastError : klma + lastWords,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 26),
                  ),
                ),
                Center(
                    child: vid == ''
                        ? Container(
                            height: 360,
                            width: 260,
                            child: Column(
                              children: [
                                Image.asset(
                                    'assets/deaf-man-emoji-clipart-xl.png'),
                              ],
                            ),
                          )
                        : Container(
                            width: 260,
                            height: 360,
                            child: Show(
                              vidName: vid,
                            ),
                          )),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Container buildFloatingButton() {
    return Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: .26,
                spreadRadius: level * 1.5,
                color: Colors.black.withOpacity(.05))
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: GestureDetector(
          child: Icon(
            Icons.mic,
            size: 31,
            color: Color(0xFF681006),
          ),
          onTap: () {
            startListening();
          },
        ),
      );
  }


  void startListening() {
    lastError = '';
    lastWords = '';
    klma = '';
    vid = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 5),
        pauseFor: Duration(seconds: 5),
        partialResults: false,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    ++resultListened;
    print('Result listener $resultListened');
    setState(() {
      lastWords = '${result.recognizedWords}';
      klma = 'الكلمة هى : ';
      vid = PlayVideo(lastWords);
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      if (error.errorMsg == 'error_no_match')
        lastError = 'من فضلك تحدث قبل ان يمر 5 ثوانى من بعد الضغط على الزر';
      else if (error.errorMsg == 'error_network')
        lastError = 'من فضلك قم بفتح الانترنت';
      else
        lastError = error.errorMsg;
      print(error.errorMsg);
    });
  }

  void statusListener(String status) {
    // print(
    // 'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  String PlayVideo(String word) {
    if (word == "واحد"|| word == '1')
      return "1.mp4";
    else if (word == "اثنين" || word == "اتنين"|| word == '2')
      return "2.mp4";
    else if (word == "ثلاثة" ||
        word == "تلاتة" ||
        word == "ثلاثه" ||
        word == "تلاته"|| word == '3')
      return "3.mp4";
    else if (word == 'اربعة' ||
        word == 'أربعة' ||
        word == 'اربعه' ||
        word == 'أربعه'|| word == '4')
      return "4.mp4";
    else if (word == 'خمسه' || word == 'خمسة'|| word == '6')
      return "5.mp4";
    else if (word == 'سته' || word == 'ستة'|| word == '6')
      return "6.mp4";
    else if (word == 'سبعه' || word == 'سبعة'|| word == '7')
      return "7.mp4";
    else if (word == 'ثمانية' ||
        word == 'ثمانيه' ||
        word == 'تمانية' ||
        word == 'تمانيه'|| word == '8')
      return "8.mp4";
    else if (word == 'تسعه' || word == 'تسعة'|| word == '9')
      return "9.mp4";
    else if (word == 'عشرة' || word == 'عشره'|| word == '10')
      return "10.mp4";
    else if (word == 'اخبارك' || word == 'أخبارك')
      return "3aml.mp4";
    else if (word == 'اهلا' ||
        word == 'أهلا' ||
        word == 'اهلن' ||
        word == 'أهلن')
      return "ahln.mp4";
    else if (word == 'اسمك' || word == 'اسم')
      return "esmk.mp4";
    else if (word == 'نتعرف' || word == 'اتعرف')
      return "Nt3rf.mp4";
    else if (word == 'حاضر')
      return "7adr.mp4";
    else if (word == 'العنوان' || word == 'عنوان'|| word == 'عنوانك')
      return "el3nwan.mp4";
    else if (word == 'فاضى' || word == 'فاضي')
      return "fady.mp4";
    else if (word == 'اسف' || word == 'أسف'|| word == 'إسف')
      return "2sf2.mp4";
    else if (word == 'شكرا' || word == 'شكر')
      return "4krn.mp4";
    else if (word == 'كويس')
      return "kwys.mp4";
    else
      return "";
  }
}
