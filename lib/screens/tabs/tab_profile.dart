import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget build(BuildContext context) {
    var uid = StudentServicesApp.auth.currentUser.uid;
    Future<DocumentSnapshot> myInfo =
        FirebaseFirestore.instance.collection('users').doc(uid).get();

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: _isLoading
          ? CircularProgressIndicator()
          : Container(
              margin: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.12,
                      width: size.width,
                      alignment: Alignment.center,
                      child: FutureBuilder(
                          future: myInfo,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return MyText(
                                text:
                                    '${snapshot.data['firstName'][0].toUpperCase()}${snapshot.data['lastName'][0].toUpperCase()}',
                                size: 45,
                                weight: FontWeight.w700,
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    SizedBox(
                      height: 20,
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
                                    // First name
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 5, left: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'First Name',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
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
                                    // Last name
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 5, left: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Last Name',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
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

                          // phone
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              top: 25,
                              bottom: 5,
                            ),
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor: mainColor,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  return value.length > 0
                                      ? null
                                      : 'Phone is empty';
                                },
                                decoration: textFormDecoration('Your phone...'),
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
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              top: 25,
                              bottom: 5,
                            ),
                            child: Text(
                              'About Me',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor: mainColor,
                              ),
                              child: TextFormField(
                                decoration: textFormDecoration('Bio...'),
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

  updateData() {
    if (_formKey.currentState.validate()) {
      _firstNameFocusNode.unfocus();
      _lastNameFocusNode.unfocus();
      _phoneFocusNode.unfocus();
      _aboutMeFocusNode.unfocus();
      setState(() {
        _isLoading = false;
      });
      try {
        var uid = StudentServicesApp.auth.currentUser.uid;
        StudentServicesApp.firebaseFirestore
            .collection('users')
            .doc(uid)
            .update({
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          'aboutMe': aboutMe,
        }).then((data) async {
          // await StudentServicesApp.sharedPreferences
          //     .setString('firstName', firstName);
          // await StudentServicesApp.sharedPreferences
          //     .setString('lastName', lastName);
          // await StudentServicesApp.sharedPreferences.setString('phone', phone);
          // await StudentServicesApp.sharedPreferences
          //     .setString('aboutMe', aboutMe);
          setState(() {
            _isLoading = false;
          });
          Fluttertoast.showToast(msg: 'Updated Successfully.');
        });
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }
  }
}
