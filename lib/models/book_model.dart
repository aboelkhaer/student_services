import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String title,
      level,
      description,
      term,
      userUID,
      userFirstName,
      price,
      userLastName,
      bookImageUrl;
  Timestamp time;

  Book({
    this.title,
    this.level,
    this.term,
    this.userUID,
    this.price,
    this.description,
    this.userFirstName,
    this.userLastName,
    this.bookImageUrl,
  });
  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    description = json['description'];
    level = json['bookLevel'];
    term = json['bookTerm'];
    userUID = json['userUID'];
    userFirstName = json['userFirstName'];
    userLastName = json['userLastName'];
    bookImageUrl = json['bookImageUrl'];
    time = json['time'];
  }
}
