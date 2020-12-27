import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_services/screens/home_screen.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/utility/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _userFirstNameController = TextEditingController();
  TextEditingController _userLastNameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPhoneController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();

  @override
  void dispose() {
    _userEmailController.dispose();
    _userPasswordController.dispose();
    _userFirstNameController.dispose();
    _userLastNameController.dispose();
    _userPhoneController.dispose();

    super.dispose();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFFFFFF),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Sign Up',
                          style: authText,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: TextFormField(
                                  controller: _userFirstNameController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: textFormDecoration('First Name'),
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: TextFormField(
                                  controller: _userLastNameController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: textFormDecoration('Last Name'),
                                ),
                              )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: TextFormField(
                              controller: _userEmailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: textFormDecoration('Email'),
                              validator: (value) {
                                return value.length > 3
                                    ? null
                                    : 'Please provide email 3+ character';
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: TextFormField(
                              controller: _userPhoneController,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration: textFormDecoration('Mobile Phone'),
                            ),
                          ),
                          TextFormField(
                            controller: _userPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            decoration: textFormDecoration('Password'),
                            validator: (value) {
                              return value.length > 3
                                  ? null
                                  : 'Please provide email 3+ character';
                            },
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
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _signInEmailPassword();
                            }
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have account? ',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'SignIn');
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: mainColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _signInEmailPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      StudentServicesApp.user = (await StudentServicesApp.auth
              .createUserWithEmailAndPassword(
                  email: _userEmailController.text.trim(),
                  password: _userPasswordController.text.trim()))
          .user;

      saveUserInfoToFireStore(StudentServicesApp.user);
      if (!StudentServicesApp.user.emailVerified) {
        await StudentServicesApp.user.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return HomeScreen(user: StudentServicesApp.user);
      }));
    } on FirebaseAuthException catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message),
      ));
      _userEmailController.text = '';
      _userPasswordController.text = '';
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Future<void> _userSetup(
  //     String userFirstName, String userLastName, String userPhone) async {
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   String uid = _auth.currentUser.uid.toString();
  //   users.add({
  //     'userFirstName': userFirstName,
  //     'userLastName': userLastName,
  //     'userPhone': userPhone,
  //     'uid': uid
  //   });
  //   return;
  // }

  Future saveUserInfoToFireStore(User fUser) async {
    FirebaseFirestore.instance.collection('users').doc(fUser.uid).set({
      'uid': fUser.uid,
      'email': fUser.email,
      'name': _userFirstNameController.text,
      'lastName': _userLastNameController.text,
      'userPhone': _userPhoneController.text,
      'userAccess': 'user',
      'url': 'fUser.photoURL',
    });
    await StudentServicesApp.sharedPreferences
        .setString(StudentServicesApp.userUID, fUser.uid);
    await StudentServicesApp.sharedPreferences
        .setString(StudentServicesApp.userEmail, fUser.email);
    await StudentServicesApp.sharedPreferences
        .setString(StudentServicesApp.userPhone, _userPhoneController.text);
    await StudentServicesApp.sharedPreferences.setString(
        StudentServicesApp.userLastName, _userLastNameController.text);
    await StudentServicesApp.sharedPreferences.setString(
        StudentServicesApp.userFirstName, _userFirstNameController.text);
    await StudentServicesApp.sharedPreferences
        .setString(StudentServicesApp.userPhotoUrl, fUser.photoURL);
  }
}
