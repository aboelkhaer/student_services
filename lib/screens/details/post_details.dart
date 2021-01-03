import 'package:flutter/material.dart';
import 'package:student_services/models/post_model.dart';
import 'package:student_services/utility/capitalize.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/my_text.dart';

class PostDetails extends StatelessWidget {
  final Post post;
  PostDetails({this.post});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage('assets/images/bg_post.png'),
                        fit: BoxFit.fill),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -size.height * 0.298),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.only(left: 20),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          MyText(
                            text:
                                'Dr. ${capitalize(post.userFirstName)} ${capitalize(post.userLastName)}',
                            color: Colors.white,
                            weight: FontWeight.bold,
                            size: 22,
                          ),
                          SizedBox(
                            width: size.width * 0.15,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Container(
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
                                      image: ExactAssetImage(
                                          'assets/images/book3.jpg'),
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
                                                bottomRight:
                                                    Radius.circular(15)),
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
                                                bottomRight:
                                                    Radius.circular(15)),
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SelectableText(
                                  post.title,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(1, 3),
                                    ),
                                  ],
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SelectableText(
                                'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
                                maxLines: null,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 1.2,
                                  height: 1.25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
