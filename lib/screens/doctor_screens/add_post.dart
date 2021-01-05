import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  TextEditingController _postUrlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    _postUrlController.dispose();
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
      body: Container(
        padding: const EdgeInsets.all(16.0),
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
                  height: 15,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  // validator: (value) {
                  //   return value.length > 0 ? null : 'Image url is empty';
                  // },
                  controller: _postUrlController,
                  keyboardType: TextInputType.url,
                  decoration: textFormDecoration('Image Url'),
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
                        Fluttertoast.showToast(msg: 'Long press to add post.');
                      },
                      child: MyText(
                        text: 'Send',
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                      onLongPress: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            _addPostToDatabase(StudentServicesApp.user);
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
    );
  }

  // Users users = Users();

  Future _addPostToDatabase(User fUser) async {
    StudentServicesApp.firebaseFirestore.collection('posts').add({
      'postTitle': _titleController.text.trim(),
      'postDescription': _descriptionController.text.trim(),
      'userUID': fUser.uid,
      'userFirstName': firstName,
      'userLastName': lastName,
      'postImageUrl': _postUrlController.text.trim(),
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
}
