import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/utility/styles.dart';
import 'package:student_services/widgets/my_text.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bookUrlController = TextEditingController();
  TextEditingController _bookDescriptionController = TextEditingController();
  TextEditingController _bookPriceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _bookUrlController.dispose();
    _titleController.dispose();
    _bookDescriptionController.dispose();
    _bookPriceController.dispose();
    super.dispose();
  }

  String levelValue;
  String termValue;
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
          text: 'Add Book',
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
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          return value.length > 0 ? null : 'Title is empty';
                        },
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        decoration: textFormDecoration('Title'),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          return value.length > 0 ? null : 'Price is empty';
                        },
                        controller: _bookPriceController,
                        keyboardType: TextInputType.number,
                        decoration: textFormDecoration('Price'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    return value.length > 0 ? null : 'Image url is empty';
                  },
                  controller: _bookUrlController,
                  keyboardType: TextInputType.url,
                  decoration: textFormDecoration('Image Url'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return value.length > 0 ? null : 'Description is empty';
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  controller: _bookDescriptionController,
                  decoration: textFormDecoration('Description'),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          RadioListTile(
                            title: Text('level 1'),
                            value: 'level 1',
                            groupValue: levelValue,
                            onChanged: (userValue) {
                              setState(() {
                                levelValue = userValue;
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text('level 2'),
                            value: 'level 2',
                            groupValue: levelValue,
                            onChanged: (userValue) {
                              setState(() {
                                levelValue = userValue;
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text('level 3'),
                            value: 'level 3',
                            groupValue: levelValue,
                            onChanged: (userValue) {
                              setState(() {
                                levelValue = userValue;
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text('level 4'),
                            value: 'level 4',
                            groupValue: levelValue,
                            onChanged: (userValue) {
                              setState(() {
                                levelValue = userValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: RadioListTile(
                              title: Text('term 1'),
                              value: 'term 1',
                              groupValue: termValue,
                              onChanged: (userValue) {
                                setState(() {
                                  termValue = userValue;
                                });
                              },
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: RadioListTile(
                              title: Text('term 2'),
                              value: 'term 2',
                              groupValue: termValue,
                              onChanged: (userValue) {
                                setState(() {
                                  termValue = userValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                        Fluttertoast.showToast(msg: 'Long press to add book.');
                      },
                      child: MyText(
                        text: 'Add',
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                      onLongPress: () async {
                        if (_formKey.currentState.validate() &&
                            levelValue != null &&
                            termValue != null) {
                          try {
                            _addBookToDatabase(StudentServicesApp.user);
                            Navigator.of(context).pop();
                            _titleController.text = '';
                            _bookDescriptionController.text = '';
                            levelValue = '';
                            termValue = '';
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

  Future _addBookToDatabase(User fUser) async {
    StudentServicesApp.firebaseFirestore.collection('books').add({
      'title': _titleController.text.trim(),
      'description': _bookDescriptionController.text.trim(),
      'userUID': fUser.uid,
      'userFirstName': firstName,
      'price': _bookPriceController.text.trim(),
      'bookLevel': levelValue,
      'bookTerm': termValue,
      'userLastName': lastName,
      'bookImageUrl': _bookUrlController.text.trim(),
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
