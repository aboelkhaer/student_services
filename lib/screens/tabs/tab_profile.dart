import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/utility/styles.dart';
import 'package:student_services/widgets/my_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _phoneController;
  TextEditingController _aboutMeController;

  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _aboutMeFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  String firstName = '';
  String lastName = '';
  String phone = '';
  String aboutMe = '';
  File _imageFile;
  String userImageUrl = '';
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFFFFFFF),
                          backgroundImage: _imageFile == null
                              ? ExactAssetImage('assets/images/avatar.png')
                              : FileImage(_imageFile),
                          radius: size.width * 0.15,
                        ),
                        Positioned(
                          right: 0,
                          bottom: -3,
                          child: GestureDetector(
                            onTap: _selectAndPickImage,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(Icons.camera_alt_outlined,
                                  size: 35, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          primaryColor: mainColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 6),
                                          child: TextFormField(
                                            decoration: textFormDecoration(
                                                'First name...'),
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              return value.length > 0
                                                  ? null
                                                  : 'First name is empty';
                                            },
                                            controller: _firstNameController,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  15),
                                            ],
                                            onChanged: (value) {
                                              firstName = value;
                                            },
                                            focusNode: _firstNameFocusNode,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          primaryColor: mainColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6, right: 8),
                                          child: TextFormField(
                                            validator: (value) {
                                              return value.length > 0
                                                  ? null
                                                  : 'Last name is empty';
                                            },
                                            decoration: textFormDecoration(
                                                'Last name...'),
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            controller: _lastNameController,
                                            onChanged: (value) {
                                              lastName = value;
                                            },
                                            focusNode: _lastNameFocusNode,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor: mainColor,
                              ),
                              child: TextFormField(
                                onChanged: (value) {
                                  phone = value;
                                },
                                validator: (value) {
                                  return value.length > 0
                                      ? null
                                      : 'Phone is empty';
                                },
                                decoration: textFormDecoration('Your phone...'),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(11),
                                ],
                                controller: _phoneController,
                                focusNode: _phoneFocusNode,
                              ),
                            ),
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor: mainColor,
                              ),
                              child: TextFormField(
                                decoration: textFormDecoration('Bio...'),
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  return value.length > 0
                                      ? null
                                      : 'Bio is empty';
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: _aboutMeController,
                                onChanged: (value) {
                                  aboutMe = value;
                                },
                                focusNode: _aboutMeFocusNode,
                              ),
                            ),
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                          ),
                        ],
                      ),
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
                            child: MyText(
                              text: 'Update',
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                updateData();
                              }
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _selectAndPickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  uploadAndSaveImage() {
    if (_imageFile == null) {
      return Fluttertoast.showToast(
        msg: 'Please select an image.',
        textColor: Colors.red,
      );
    } else {
      uploadToStorage();
    }
  }

  uploadToStorage() async {
    setState(() {
      _isLoading = true;
    });
    var uid = StudentServicesApp.auth.currentUser.uid;
    String imageFileName = uid;

    final Reference reference =
        FirebaseStorage.instance.ref().child(imageFileName);
    await reference.putFile(_imageFile);
    return await reference.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;
    });
  }

  updateData() {
    if (_formKey.currentState.validate() && _imageFile != null) {
      _firstNameFocusNode.unfocus();
      _lastNameFocusNode.unfocus();
      _phoneFocusNode.unfocus();
      _aboutMeFocusNode.unfocus();
      setState(() {
        _isLoading = false;
      });
      try {
        var uid = StudentServicesApp.auth.currentUser.uid;
        uploadAndSaveImage();

        StudentServicesApp.firebaseFirestore
            .collection('users')
            .doc(uid)
            .update({
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          'aboutMe': aboutMe,
        }).then((data) async {
          await StudentServicesApp.sharedPreferences
              .setString('firstName', firstName);
          await StudentServicesApp.sharedPreferences
              .setString('lastName', lastName);
          await StudentServicesApp.sharedPreferences.setString('phone', phone);
          await StudentServicesApp.sharedPreferences
              .setString('aboutMe', aboutMe);

          setState(() {
            _isLoading = false;
          });
          _imageFile = null;

          Fluttertoast.showToast(
              msg: 'Updated Successfully.', textColor: Colors.green);
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
