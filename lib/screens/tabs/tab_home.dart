import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_services/models/users.dart';
import 'package:student_services/screens/details/doctor_details.dart';
import 'package:student_services/utility/capitalize.dart';
import 'package:student_services/utility/config.dart';
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
                                        image:
                                            NetworkImage(users.doctorHomeImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
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
              // indecator(),
            ],
          ),
          Container(
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                  ),
                  child: Row(
                    children: [
                      drawSectionTitle('All Books'),
                    ],
                  ),
                ),
                //All books
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          _drawSingleRow(size, 1),
                          _drawSingleRow(size, 2),
                          _drawSingleRow(size, 3),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawSingleRow(size, int num) {
    // enter book model    Book book
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 7,
        shadowColor: Colors.black,
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return SinglePost(post);
            //     },
            //   ),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                SizedBox(
                  height: size.height * 0.15,
                  width: size.width * 0.23,
                  child: Image(
                    image: ExactAssetImage('assets/images/book$num.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'Hello World',
                            size: 18,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          MyText(
                            text: 'level 1',
                            size: 13,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          MyText(
                            text: 'term 2',
                            size: 13,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'DR/Mohamed Ahmed',
                            color: Colors.grey,
                            size: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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

// Book(
//         image: 'assets/images/book1.jpg',
//         title: 'DAY FOUR',
//         level: '1',
//         term: '2'),
//     Book(
//         image: 'assets/images/book1.jpg',
//         title: 'DAY FOUR',
//         level: '1',
//         term: '1'),
