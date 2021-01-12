import 'package:flutter/material.dart';
import 'package:student_services/models/book_model.dart';
import 'package:student_services/screens/booking.dart';
import 'package:student_services/utility/capitalize.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/my_text.dart';

class BookDetails extends StatelessWidget {
  final Book book;
  BookDetails({this.book});
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          height: _size.height * 0.6,
                          color: Colors.grey.shade200,
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          height: _size.height * 0.26,
                          color: mainColor,
                        ),
                        Positioned(
                          top: _size.height * 0.08,
                          child: Container(
                            alignment: Alignment.center,
                            height: _size.height * 0.4,
                            width: _size.width * 0.5,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 4),
                                    blurRadius: 10,
                                    spreadRadius: 1),
                              ],
                            ),
                            child: Image.network(
                              book.bookImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                return Container();
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          left: _size.width * 0.05,
                          top: _size.height * 0.06,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Positioned(
                          bottom: _size.height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                text: 'Price: ',
                                color: Colors.grey[700],
                              ),
                              MyText(
                                text: '${book.price} EGP',
                                color: Colors.blue,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: _size.height * 0.03,
                        bottom: _size.height * 0.15,
                      ),
                      width: _size.width * 0.7,
                      child: Column(
                        children: [
                          Text(
                            book.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: _size.height * 0.03,
                          ),
                          Text(
                            'Dr. ${capitalize(book.userLastName)} ${capitalize(book.userLastName)}',
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(0, -2))
                              ],
                              fontSize: 16,
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              decorationThickness: 0.5,
                              decorationStyle: TextDecorationStyle.wavy,
                            ),
                          ),
                          SizedBox(
                            height: _size.height * 0.03,
                          ),
                          Text(
                            book.description,
                            textAlign: TextAlign.start,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingScreen(book: book)));
              },
              child: Container(
                alignment: Alignment.center,
                width: _size.width * 0.5,
                height: _size.height * 0.1,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                ),
                child: MyText(
                  text: 'Book Now',
                  size: 20,
                  weight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
