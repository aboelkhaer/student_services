import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:student_services/model.dart/home_carousel_model.dart';
import 'package:student_services/screens/doctor_details.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(2);
  List<ImageDoctorModel> doctors;

  void _doctorHomeImages() {
    doctors = List<ImageDoctorModel>();
    doctors.add(ImageDoctorModel(
        'DR/Ahmed Mahmoud', 'https://img.youm7.com/large/620151213041930.jpg'));
    doctors.add(ImageDoctorModel('DR/Mohamed Ahmed',
        'https://striveme.com/img/article/2742/5b1bc841e9967.jpg'));
    doctors.add(ImageDoctorModel('DR/Mostafa Mahmoud',
        'https://img.youm7.com/large/201710060136413641.jpg'));
    doctors.add(ImageDoctorModel('DR/Ibrahiem Abdo',
        'https://www.neshanstyle.com/blog/wp-content/uploads/2019/05/stock-man-in-suit-2-1-1024x576.jpg'));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _doctorHomeImages();
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: size.height * 0.35,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      GestureDetector(
                          child: Hero(
                            tag: doctors[index].image,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(doctors[index].image),
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
                        child: Text(
                          doctors[index].title,
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: 200,
                  color: Colors.red,
                );
              },
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
}
