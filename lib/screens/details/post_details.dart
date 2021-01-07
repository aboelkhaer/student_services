import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:student_services/models/book_model.dart';
import 'package:student_services/models/post_model.dart';
import 'package:student_services/utility/capitalize.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/books_list.dart';
import 'package:intl/intl.dart';
import 'package:student_services/widgets/my_text.dart';

class PostDetails extends StatelessWidget {
  final Post post;
  PostDetails({this.post});
  // var uid = StudentServicesApp.user.uid;
  @override
  Widget build(BuildContext context) {
    CollectionReference myPosts =
        StudentServicesApp.firebaseFirestore.collection('posts');
    int timeInMillis = post.time.millisecondsSinceEpoch;
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    var formattedDate = DateFormat.yMMMMEEEEd().format(date);
    Size size = MediaQuery.of(context).size;
    Query myBooks = StudentServicesApp.firebaseFirestore
        .collection('books')
        .where('userUID', isEqualTo: post.userUID)
        .orderBy('time', descending: true);
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: StreamBuilder(
            stream: myPosts.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: FutureBuilder(
                    future: post.getUserPostsFuture(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF9FaFa),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                children: [
                                  _sizedBox(height: size.height * 0.03),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.arrow_back_ios),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      capitalize(post.title),
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  _sizedBox(height: size.height * 0.01),
                                  Container(
                                    width: double.infinity,
                                    child: Image.network(
                                      post.postImageUrl,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace stackTrace) {
                                        return Container();
                                      },
                                    ),
                                  ),
                                  _sizedBox(height: size.height * 0.03),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Material(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            child: FutureBuilder(
                                              future: _getUserProfileImage(
                                                  context, post.userUID),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: snapshot.data ==
                                                                null
                                                            ? AssetImage(
                                                                'assets/images/avatar.png')
                                                            : snapshot.data,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                  );
                                                }
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Container(
                                                    child:
                                                        CircularProgressIndicator(),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                  );
                                                }
                                                return Container();
                                              },
                                            ),
                                          ),
                                        ),
                                        _sizedBox(
                                            height: size.height * 0.03,
                                            width: size.width * 0.02),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'By Dr. ${capitalize(post.userFirstName)} ${capitalize(post.userLastName)} ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              formattedDate,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  _sizedBox(height: size.height * 0.03),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 50,
                                      left: 50,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 50,
                                      left: 50,
                                    ),
                                    child: SelectableText(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  _sizedBox(height: size.height * 0.05),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 16,
                                            bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                      StreamBuilder<QuerySnapshot>(
                                        stream: myBooks.snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  'Some thing went error.'),
                                            );
                                          }
                                          if (snapshot.data == null) {
                                            return Center(
                                              child: MyText(text: 'No Data'),
                                            );
                                          }
                                          return Container(
                                            height: size.height * 0.3,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshot.data.docs.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                Book book = Book.fromJson(
                                                    snapshot.data.docs[index]
                                                        .data());

                                                return singleBook(
                                                    context, book);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }),
              );
            }),
      ),
    );
  }

  Widget _sizedBox({double height, double width}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  _getUserProfileImage(BuildContext context, String imageName) async {
    NetworkImage image;
    await FireStoreService.loadImage(context, imageName).then((value) {
      image = NetworkImage(value.toString());
    });
    return image;
  }
}

class FireStoreService extends ChangeNotifier {
  FireStoreService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
