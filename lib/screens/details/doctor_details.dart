import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_services/models/book_model.dart';
import 'package:student_services/models/post_model.dart';
import 'package:student_services/models/users.dart';
import 'package:student_services/utility/capitalize.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/widgets/books_list.dart';
import 'package:student_services/widgets/my_text.dart';
import 'package:student_services/widgets/posts_body.dart';

class DoctorDetails extends StatelessWidget {
  final Users users;
  DoctorDetails({this.users});
  @override
  Widget build(BuildContext context) {
    Query doctorPosts = StudentServicesApp.firebaseFirestore
        .collection('posts')
        .where('userUID', isEqualTo: users.id)
        .orderBy('time', descending: true);
    Size _size = MediaQuery.of(context).size;

    Query myBooks = StudentServicesApp.firebaseFirestore
        .collection('books')
        .where('userUID', isEqualTo: users.id)
        .orderBy('time', descending: true);
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                // Handel Hero Error ---------------------------------------------
                Hero(
                  flightShuttleBuilder: (BuildContext flightContext,
                          Animation<double> animation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext) =>
                      Material(child: toHeroContext.widget),
                  //----------------------------
                  tag: users.doctorHomeImage,
                  child: Container(
                    width: _size.width,
                    height: _size.height * 0.30,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15,
                            spreadRadius: 1),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4.0, -8.0),
                            blurRadius: 8,
                            spreadRadius: 1),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(users.doctorHomeImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
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
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: _size.height * 0.05,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: _size.width * 0.04,
                        ),
                        MyText(
                          text:
                              'Dr. ${capitalize(users.firstName)} ${capitalize(users.lastName)}',
                          size: 25,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: _size.width * 0.04,
                        ),
                        MyText(
                          text: capitalize(users.aboutMe),
                          color: Colors.grey[500],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: 'Books',
                                size: 19,
                                weight: FontWeight.w500,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                        // Start Book Stream ---------------------------------------------
                        StreamBuilder<QuerySnapshot>(
                          stream: myBooks.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Some thing went error.'),
                              );
                            }
                            return Container(
                              height: _size.height * 0.3,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  Book book = Book.fromJson(
                                      snapshot.data.docs[index].data());

                                  return singleBook(context, book);
                                },
                              ),
                            );
                          },
                        ),
                        // End Book Stream ---------------------------------------------
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: 16,
                bottom: 16,
              ),
              child: Column(
                children: [
                  MyText(
                    text: 'Posts',
                    size: 18,
                    weight: FontWeight.w500,
                  ),
                  // Start Posts Stream ---------------------------------------------
                  StreamBuilder<QuerySnapshot>(
                    stream: doctorPosts.snapshots(),
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
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 40,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          Post post =
                              Post.fromJson(snapshot.data.docs[index].data());

                          return postBody(post, context);
                        },
                      );
                    },
                  ),
                  // End Posts Stream ---------------------------------------------
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
