import 'package:flutter/material.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/my_text.dart';

class LibarianScreen extends StatefulWidget {
  @override
  _LibarianScreenState createState() => _LibarianScreenState();
}

class _LibarianScreenState extends State<LibarianScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: mainColor,
        title: MyText(
          text: 'Orders',
          size: 20,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16, left: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'LevelOne');
                      },
                      child: container(
                          size.height * 0.15, size.width * 0.4, 'Level 1'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'LevelTwo');
                      },
                      child: container(
                          size.height * 0.15, size.width * 0.4, 'Level 2'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16, left: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'LevelThree');
                      },
                      child: container(
                          size.height * 0.15, size.width * 0.4, 'Level 3'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'LevelFour');
                      },
                      child: container(
                          size.height * 0.15, size.width * 0.4, 'Level 4'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget container(double height, double width, String text) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      child: MyText(
        text: text,
        size: 25,
        weight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
