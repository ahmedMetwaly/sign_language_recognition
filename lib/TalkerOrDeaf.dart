import"package:flutter/material.dart";
import 'package:sign_language_detector/talker.dart';
import 'package:sign_language_detector/constants.dart';
import 'package:sign_language_detector/deaf2.dart';
class SpeachOrListen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "التعرف على لغة الإشارة العربية",
                style: TextStyle(
                    color: Color(0xFFE99600),
                    fontWeight: FontWeight.w700,
                    fontSize: 28),
              ),
              SizedBox(height: 14),
              Center(
                child:Container(
                  height: 300,
                  width: 260,
                  child: Column(
                    children: [
                      Image.asset(
                          'assets/deaf-man-emoji-clipart-xl.png'),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                )
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Deaf2()),
                        );

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                            color: Color(0xFFE99600),
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                            'ابكم' ,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Talker()),
                        );

                      },

                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                            color: Color(0xFFE99600),
                            borderRadius: BorderRadius.circular(6)),
                        child: Text('متكلم',style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
