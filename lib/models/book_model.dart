import 'package:student_services/models/doctor_model.dart';

class Book {
  String title, auther, level, term, image;

  Doctor doctor;

  Book(
      {this.title,
      this.auther,
      this.level,
      this.term,
      this.image,
      this.doctor});
}
