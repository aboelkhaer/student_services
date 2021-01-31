import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_services/models/book_model.dart';
import 'package:student_services/models/users.dart';
import 'package:student_services/screens/booking.dart';
import 'package:student_services/screens/details/book_details.dart';
import 'package:student_services/screens/details/doctor_details.dart';
import 'package:student_services/utility/capitalize.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/widgets/books_list.dart';
import 'package:student_services/widgets/static_widgets.dart';
import 'package:student_services/widgets/my_text.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Query usersStream = StudentServicesApp.firebaseFirestore
        .collection('users')
        .where('admin', isEqualTo: true);

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              // Home doctor image
              StreamBuilder(
                  stream: usersStream.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null)
                      return CircularProgressIndicator();
                    return CarouselSlider.builder(
                      options: CarouselOptions(
                        height: size.height * 0.25,
                        autoPlay: true,
                        viewportFraction: 1,
                      ),
                      itemBuilder: (context, index) {
                        Users users =
                            Users.fromJson(snapshot.data.docs[index].data());

                        return Stack(
                          children: [
                            GestureDetector(
                                child: Hero(
                                  tag: users.doctorHomeImage,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          users.doctorHomeImage == null
                                              ? 'https://i.etsystatic.com/5651657/d/il/a968f6/2052052472/il_340x270.2052052472_ffey.jpg?version=0'
                                              : users.doctorHomeImage,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // child: users.doctorHomeImage == null
                                    //     ? Image(
                                    //         image: ExactAssetImage(
                                    //             'assets/images/doctorImageHome.jpg'),
                                    //         fit: BoxFit.fitWidth,
                                    //       )
                                    //     : Image.network(
                                    //         users.doctorHomeImage,
                                    //         fit: BoxFit.fitWidth,
                                    //         errorBuilder: (BuildContext context,
                                    //             Object exception,
                                    //             StackTrace stackTrace) {
                                    //           return Image(
                                    //             image: ExactAssetImage(
                                    //                 'assets/images/doctorImageHome.jpg'),
                                    //             fit: BoxFit.fitWidth,
                                    //           );
                                    //         },
                                    //       ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push<Widget>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DoctorDetails(users: users),
                                    ),
                                  );
                                }),
                            Positioned(
                              bottom: 35,
                              left: 30,
                              child: MyText(
                                text:
                                    'Dr. ${capitalize(users.firstName)} ${capitalize(users.lastName)}',
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: snapshot.data.docs.length,
                    );
                  }),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _containerIndicator(),
                    SizedBox(
                      width: 5,
                    ),
                    _containerIndicator(),
                    SizedBox(
                      width: 5,
                    ),
                    _containerIndicator(),
                    SizedBox(
                      width: 5,
                    ),
                    _containerIndicator(),
                  ],
                ),
              ),
            ],
          ),
          AllBooks(),
        ],
      ),
    );
  }

  Widget _containerIndicator() {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.white),
    );
  }
}

class AllBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query myBooks = StudentServicesApp.firebaseFirestore
        .collection('books')
        .orderBy('time', descending: true);

    return Container(
      color: Colors.grey.shade100,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Row(
              children: [
                drawSectionTitle('All Books'),
              ],
            ),
          ),
          //All books
          StreamBuilder<QuerySnapshot>(
              stream: myBooks.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Some thing went error.'),
                  );
                }
                return ListView.builder(
                    padding: EdgeInsets.only(bottom: 40),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      Book book =
                          Book.fromJson(snapshot.data.docs[index].data());

                      return Column(
                        children: [
                          _drawSingleRow(book, context),
                        ],
                      );
                    });
              })
        ],
      ),
    );
  }

  Widget _drawSingleRow(Book book, BuildContext context) {
    var size = MediaQuery.of(context).size;
    // enter book model    Book book
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.28,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BookDetails(
                  book: book,
                );
              },
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(right: 10),
          child: Row(
            children: [
              singleBook(context, book),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: MyText(
                              text: book.title,
                              size: 17,
                              weight: FontWeight.bold,
                              align: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: MyText(
                            text:
                                'By Dr. ${capitalize(book.userFirstName)} ${capitalize(book.userLastName)}',
                            size: 17,
                            color: Colors.grey,
                            weight: FontWeight.w500,
                            align: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: MyText(
                            text: '${book.price} EGP',
                            size: 18,
                            color: Colors.blue,
                            weight: FontWeight.w500,
                            align: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 40,
                        right: 16,
                      ),
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: RaisedButton(
                          child: MyText(
                            text: 'Book Now',
                            color: Colors.white,
                            weight: FontWeight.bold,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BookingScreen(book: book)));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
