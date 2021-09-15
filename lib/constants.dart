import 'package:flutter/material.dart';

import 'TalkerOrDeaf.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xFFE99600),
    title: Center(
      child: Text(
        'التعرف على الكلمة المراد تحويلها ',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Color(0xFF681006),
        ),
      ),
    ),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_outlined,
        color: Colors.black,
        size: 31,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SpeachOrListen()),
        );
      },
    ),
  );
}





