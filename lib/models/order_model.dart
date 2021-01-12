import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String authorUID,
      bookLevel,
      bookTerm,
      bookTitle,
      bookAuthor,
      customerAdress,
      customerName,
      customerPhone,
      customerUID;
  Timestamp time;

  Order({
    this.authorUID,
    this.bookLevel,
    this.bookTerm,
    this.bookTitle,
    this.bookAuthor,
    this.customerAdress,
    this.customerName,
    this.customerPhone,
    this.customerUID,
    this.time,
  });

  Order.fromJson(Map<String, dynamic> json) {
    authorUID = json['authorUID'];
    bookLevel = json['bookLevel'];
    bookTerm = json['bookTerm'];
    bookTitle = json['bookTitle'];
    bookAuthor = json['bookAuthor'];
    customerAdress = json['customerAdress'];
    customerName = json['customerName'];
    customerPhone = json['customerPhone'];
    customerUID = json['customerUID'];
    time = json['time'];
  }
}
