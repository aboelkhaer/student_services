import 'package:flutter/material.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/my_text.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: MyText(
          text: 'Dashboard',
          size: 20,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16, left: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'AddPost');
                    },
                    child: container(
                        size.height * 0.15, size.width * 0.4, 'Add Post'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8, left: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'ShowPosts');
                    },
                    child: container(
                        size.height * 0.15, size.width * 0.4, 'Show Posts'),
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
                    onTap: () {},
                    child: container(
                        size.height * 0.15, size.width * 0.4, 'Add Book'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8, left: 16),
                  child: GestureDetector(
                    onTap: () {},
                    child: container(
                        size.height * 0.15, size.width * 0.4, 'Show Books'),
                  ),
                ),
              ],
            ),
          ],
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
