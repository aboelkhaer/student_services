import 'package:flutter/material.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/my_text.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: MyText(
          text: 'Change Language',
          size: 20,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello'),
          ],
        ),
      ),
    );
  }
}
