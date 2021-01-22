import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_services/models/book_model.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/my_text.dart';

class ShowBooks extends StatefulWidget {
  @override
  _ShowBooksState createState() => _ShowBooksState();
}

class _ShowBooksState extends State<ShowBooks> {
  @override
  Widget build(BuildContext context) {
    var uid = StudentServicesApp.auth.currentUser.uid;
    Query books = FirebaseFirestore.instance
        .collection('books')
        .where('userUID', isEqualTo: uid)
        .orderBy('time', descending: true);
    Query orders = FirebaseFirestore.instance
        .collection('orders')
        //TODO create number of booking
        .where('userUID', isEqualTo: uid)
        .orderBy('time', descending: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: MyText(
          text: 'Your Books',
          size: 20,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: books.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              Book book = Book.fromJson(snapshot.data.docs[index].data());
              return ListTile(
                title: Text(book.title),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    snapshot.data.docs[index].reference.delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
