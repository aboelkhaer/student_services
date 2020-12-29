import 'package:flutter/material.dart';
import 'package:student_services/widgets/custom_text.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyText(
          text: 'Change password',
          size: 18,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: Text('Change password page'),
      ),
    );
  }
}
