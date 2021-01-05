import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:student_services/models/book_model.dart';
import 'package:student_services/models/post_model.dart';
import 'package:student_services/utility/capitalize.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/my_text.dart';
import 'package:intl/intl.dart';

class PostDetails extends StatelessWidget {
  final Post post;
  PostDetails({this.post});
  //post date

  @override
  Widget build(BuildContext context) {
    CollectionReference myPosts =
        StudentServicesApp.firebaseFirestore.collection('posts');
    int timeInMillis = post.time.millisecondsSinceEpoch;
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    var formattedDate = DateFormat.yMMMMEEEEd().format(date);
    Size size = MediaQuery.of(context).size;
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
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText(
                                          text: 'Doctor Books',
                                          size: 19,
                                          weight: FontWeight.bold,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                  _bookList(context: context),
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

  Widget _bookList({BuildContext context, Book book}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                width: size.width * 0.3,
                height: size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.black,
                  image: DecorationImage(
                    image: ExactAssetImage('assets/images/book3.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 30,
                  left: 15,
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 0.16,
                        height: size.height * 0.033,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        alignment: Alignment.center,
                        child: MyText(
                          text: 'level 2',
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: size.width * 0.16,
                        height: size.height * 0.033,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        alignment: Alignment.center,
                        child: MyText(
                          text: 'term 2',
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
            ],
          );
        },
      ),
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

// class PostDetails extends StatelessWidget {
//   final Post post;
//   PostDetails({this.post});
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: size.height * 0.4,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: ExactAssetImage('assets/images/bg_post.png'),
//                         fit: BoxFit.fill),
//                   ),
//                 ),
//                 Positioned(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: size.height * 0.1,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             padding: EdgeInsets.only(left: 20),
//                             icon: Icon(
//                               Icons.arrow_back_ios,
//                               size: 30,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                           MyText(
//                             text:
//                                 'Dr. ${capitalize(post.userFirstName)} ${capitalize(post.userLastName)}',
//                             color: Colors.white,
//                             weight: FontWeight.bold,
//                             size: 22,
//                           ),
//                           SizedBox(
//                             width: size.width * 0.15,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Transform.translate(
//                   offset: Offset(0, size.height * 0.2),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: size.height * 0.04,
//                       ),
// Container(
//   height: size.height * 0.3,
//   child: ListView.builder(
//     shrinkWrap: true,
//     itemCount: 4,
//     scrollDirection: Axis.horizontal,
//     itemBuilder: (context, index) {
//       return Stack(
//         children: [
//           Container(
//             margin: EdgeInsets.all(16),
//             width: size.width * 0.3,
//             height: size.height * 0.25,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               // color: Colors.black,
//               image: DecorationImage(
//                 image: ExactAssetImage(
//                     'assets/images/book3.jpg'),
//                 fit: BoxFit.cover,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 7,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//           ),
//                                 Positioned(
//                                     bottom: 30,
//                                     left: 15,
//                                     child: Column(
//                                       children: [
//                                         Container(
//                                           width: size.width * 0.16,
//                                           height: size.height * 0.033,
//                                           decoration: BoxDecoration(
//                                             color: mainColor,
//                                             borderRadius: BorderRadius.only(
//                                                 topRight: Radius.circular(15),
//                                                 bottomRight:
//                                                     Radius.circular(15)),
//                                           ),
//                                           alignment: Alignment.center,
//                                           child: MyText(
//                                             text: 'level 2',
//                                             size: 14,
//                                             weight: FontWeight.w600,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Container(
//                                           width: size.width * 0.16,
//                                           height: size.height * 0.033,
//                                           decoration: BoxDecoration(
//                                             color: mainColor,
//                                             borderRadius: BorderRadius.only(
//                                                 topRight: Radius.circular(15),
//                                                 bottomRight:
//                                                     Radius.circular(15)),
//                                           ),
//                                           alignment: Alignment.center,
//                                           child: MyText(
//                                             text: 'term 2',
//                                             size: 14,
//                                             weight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * 0.04,
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(20),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SelectableText(
//                                   post.title,
//                                   style: TextStyle(
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 30,
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 2,
//                                       blurRadius: 2,
//                                       offset: Offset(0, 3),
//                                     ),
//                                   ],
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Column(
//                                 children: [
//                                   SelectableText(
//                                     'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
//                                     maxLines: null,
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       letterSpacing: 1.2,
//                                       height: 1.25,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // SizedBox(
//                             //   height: size.height * 0.3,
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class FireStoreService extends ChangeNotifier {
  FireStoreService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
