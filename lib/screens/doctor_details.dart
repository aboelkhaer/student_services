import 'package:flutter/material.dart';
import 'package:student_services/models/doctor_model.dart';

class DoctorDetails extends StatelessWidget {
  final Doctor doctor;
  DoctorDetails({this.doctor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: doctor.doctorImage,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15,
                        spreadRadius: 1),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 8,
                        spreadRadius: 1),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(doctor.doctorImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(doctor.doctorTitle),
          ],
        ),
      ),
    );
  }
}
