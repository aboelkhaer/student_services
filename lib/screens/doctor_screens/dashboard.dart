import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/utility/styles.dart';
import 'package:student_services/widgets/my_text.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController _homeImageUrlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _homeImageUrlController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.all(16),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return value.length > 0 ? null : 'Full Name is empty';
                  },
                  controller: _homeImageUrlController,
                  keyboardType: TextInputType.url,
                  decoration: textFormDecoration('Home Image Url'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 24,
                left: 16,
                right: 16,
              ),
              child: SizedBox(
                height: 50,
                width: size.width * 0.3,
                child: RaisedButton(
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : MyText(
                          text: 'Set Image',
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  onPressed: () async {
                    _updateHomeImage();
                  },
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
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
                    onTap: () {
                      Navigator.pushNamed(context, 'AddBook');
                    },
                    child: container(
                        size.height * 0.15, size.width * 0.4, 'Add Book'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8, left: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'ShowBooks');
                    },
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

  _updateHomeImage() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        var uid = StudentServicesApp.auth.currentUser.uid;

        StudentServicesApp.firebaseFirestore
            .collection('users')
            .doc(uid)
            .update({
          'doctorHomeImage': _homeImageUrlController.text,
        }).then((data) async {
          setState(() {
            _isLoading = false;
            _homeImageUrlController.text = '';
          });

          Fluttertoast.showToast(msg: 'Done.', textColor: Colors.green);
        });
      } on FirebaseException catch (e) {
        print(e.message);
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Put your image, please.',
        textColor: Colors.red,
      );
    }
  }
}
