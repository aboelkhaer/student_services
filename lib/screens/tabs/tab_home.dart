import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:student_services/screens/doctor_details.dart';
import 'package:student_services/widgets/static_widgets.dart';
import 'package:student_services/models/doctor_model.dart';
import 'package:student_services/widgets/custom_text.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(2);
  List<Doctor> doctors;

  void _doctorHomeImages() {
    doctors = List<Doctor>();
    doctors.add(Doctor(
        'DR/Ahmed Mahmoud', 'https://img.youm7.com/large/620151213041930.jpg'));
    doctors.add(Doctor('DR/Mohamed Ahmed',
        'https://striveme.com/img/article/2742/5b1bc841e9967.jpg'));
    doctors.add(Doctor('DR/Mostafa Mahmoud',
        'https://img.youm7.com/large/201710060136413641.jpg'));
    doctors.add(Doctor('DR/Ibrahiem Abdo',
        'https://www.neshanstyle.com/blog/wp-content/uploads/2019/05/stock-man-in-suit-2-1-1024x576.jpg'));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _doctorHomeImages();
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: size.height * 0.25,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      GestureDetector(
                          child: Hero(
                            tag: doctors[index].doctorImage,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(doctors[index].doctorImage),
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
                                    DoctorDetails(doctor: doctors[index]),
                              ),
                            );
                          }),
                      Positioned(
                        bottom: 35,
                        left: 30,
                        child: MyText(
                          text: doctors[index].doctorTitle,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: doctors.length,
              ),
              indecator(),
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

  Widget indecator() {
    return Positioned(
      bottom: 8,
      left: 0,
      right: 0,
      child: PageViewIndicator(
        pageIndexNotifier: _pageViewNotifier,
        length: doctors.length,
        indicatorPadding: EdgeInsets.all(4),
        normalBuilder: (animationController, index) => Circle(
          size: 3.0,
          color: Colors.grey[200],
        ),
        highlightedBuilder: (animationController, index) => ScaleTransition(
          scale: CurvedAnimation(
            parent: animationController,
            curve: Curves.ease,
          ),
          child: Circle(
            size: 3.0,
            color: Colors.white,
          ),
        ),
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
                          // CustomText(
                          //   text: 'level 1',
                          //   size: 13,
                          //   color: Colors.blue,
                          // ),
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
                          // Row(
                          //   children: [
                          //     CustomText(
                          //       text: 'term 2',
                          //       size: 13,
                          //       color: Colors.blue,
                          //     ),
                          //   ],
                          // ),
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
}
