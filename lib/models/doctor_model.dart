import 'package:student_services/models/book_model.dart';

class Doctor {
  // String _doctorId;
  String _doctorTitle;

  String _doctorImage;
  // List<Book> books;

  Doctor(this._doctorTitle, this._doctorImage);

  String get doctorTitle => _doctorTitle;
  String get doctorImage => _doctorImage;
  // List<Book> get books => _books;
  // String get doctorId => _doctorId;
}
