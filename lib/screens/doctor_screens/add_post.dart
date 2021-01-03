import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_services/models/users.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/utility/styles.dart';
import 'package:student_services/widgets/my_text.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
  }

  @override
  void initState() {
    readSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: MyText(
          text: 'Add Post',
          size: 20,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return value.length > 0 ? null : 'Title is empty';
                    },
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    decoration: textFormDecoration('Title'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      return value.length > 0 ? null : 'Description is empty';
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    controller: _descriptionController,
                    decoration: textFormDecoration('Description'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      bottom: 24,
                      left: 16,
                      right: 16,
                    ),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: 'Long press to add post.');
                        },
                        child: MyText(
                          text: 'Send',
                          color: Colors.white,
                          weight: FontWeight.bold,
                        ),
                        onLongPress: () async {
                          if (_formKey.currentState.validate()) {
                            try {
                              _getUserFromSharedPref(StudentServicesApp.user);
                              Navigator.of(context).pop();
                              _titleController.text = '';
                              _descriptionController.text = '';
                              Fluttertoast.showToast(
                                  msg: 'Done', textColor: Colors.green);
                            } on FirebaseException catch (e) {
                              Fluttertoast.showToast(
                                  msg: e.message, textColor: Colors.red);
                            }
                          } else {
                            Fluttertoast.showToast(msg: 'Enter data first.');
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Users users = Users();
  Future _getUserFromSharedPref(User fUser) async {
    StudentServicesApp.firebaseFirestore.collection('posts').add({
      'postTitle': _titleController.text.trim(),
      'postDescription': _descriptionController.text.trim(),
      'userUID': fUser.uid,
      'userFirstName': firstName,
      'userLastName': lastName,
      'postImage': 'non image',
      'time': DateTime.now(),
    });
  }

  String firstName = '';
  String lastName = '';

  readSharedPref() async {
    StudentServicesApp.sharedPreferences =
        await SharedPreferences.getInstance();
    firstName = StudentServicesApp.sharedPreferences
        .getString(StudentServicesApp.userFirstName);
    lastName = StudentServicesApp.sharedPreferences
        .getString(StudentServicesApp.userLastName);
    setState(() {});
  }

  // YYDialog _showDialog() {
  //   return YYDialog().build(context)
  //     ..width = MediaQuery.of(context).size.width * 0.7
  //     ..height = MediaQuery.of(context).size.height * 0.2
  //     ..widget(
  //       Container(
  //         margin: EdgeInsets.all(16),
  //         child: Column(
  //           children: [
  //             Row(
  //               children: [
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 MyText(
  //                   text: 'Add post, sure?',
  //                   size: 18,
  //                 ),
  //               ],
  //             ),
  //             SizedBox(
  //               height: MediaQuery.of(context).size.height * 0.05,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                     child: Text('Cancel'),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 15,
  //                 ),
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     try {
  //                       _getUserFromSharedPref(StudentServicesApp.user);
  //                       Navigator.of(context).pop();
  //                       _titleController.text = '';
  //                       _descriptionController.text = '';
  //                       Fluttertoast.showToast(
  //                           msg: 'Done', textColor: Colors.green);
  //                     } on FirebaseException catch (e) {
  //                       Fluttertoast.showToast(
  //                           msg: e.message, textColor: Colors.red);
  //                     }
  //                   },
  //                   child: Container(
  //                     margin: EdgeInsets.symmetric(horizontal: 10),
  //                     child: Text('Yes'),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     )
  //     ..show();
  // }
}
