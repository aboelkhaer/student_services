import 'package:flutter/material.dart';
import 'package:student_services/utility/constans.dart';

class DoctorPanal extends StatefulWidget {
  @override
  _DoctorPanalState createState() => _DoctorPanalState();
}

class _DoctorPanalState extends State<DoctorPanal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('doctor panal'),
      ),
    );
  }
}
