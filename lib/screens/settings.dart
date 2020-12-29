import 'package:flutter/material.dart';
import 'package:student_services/widgets/custom_text.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyText(
          text: 'Settings',
          size: 18,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: Text('Settings page'),
      ),
    );
  }
}
