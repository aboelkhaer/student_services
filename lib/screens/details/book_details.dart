import 'package:flutter/material.dart';
import 'package:student_services/models/book_model.dart';

class BookDetails extends StatelessWidget {
  final Book book;
  BookDetails({this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(book.title),
      ),
    );
  }
}
