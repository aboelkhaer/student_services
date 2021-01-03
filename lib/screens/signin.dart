import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_services/screens/home_screen.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/utility/styles.dart';
import 'package:student_services/widgets/my_text.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();

  @override
  void dispose() {
    _userEmailController.dispose();
    _userPasswordController.dispose();
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
                        MyText(
                          text: 'Sign In',
                          size: 28,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: TextFormField(
                              validator: (value) {
                                return value.length > 0
                                    ? null
                                    : 'Email is empty';
                              },
                              controller: _userEmailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: textFormDecoration('Email'),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              return value.length > 0
                                  ? null
                                  : 'Password is empty';
                            },
                            controller: _userPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: textFormDecoration('Password'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: MyText(
                            text: 'Forgot Password?',
                            color: Colors.grey[700],
                            size: 14,
                          ),
                        ),
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
                            text: 'Sign In',
                            color: Colors.white,
                            weight: FontWeight.bold,
                          ),
                          // Text(
                          //   'Sign In',
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 16,
                          //     letterSpacing: 1,
                          //   ),
                          // ),
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
                        MyText(
                          text: 'Don\'t have account? ',
                          color: Colors.grey[700],
                          size: 14,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'SignUp');
                          },
                          child: Text(
                            'Register now',
                            style: TextStyle(
                              fontSize: 14,
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
              .signInWithEmailAndPassword(
                  email: _userEmailController.text,
                  password: _userPasswordController.text))
          .user;
      // if (!StudentServicesApp.user.emailVerified) {
      //   await StudentServicesApp.user.sendEmailVerification();
      // }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return HomeScreen(user: StudentServicesApp.user);
      }));
    } on FirebaseAuthException catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message),
      ));
      print(e.message);
      _userPasswordController.text = '';
    }
    setState(() {
      _isLoading = false;
    });
  }
}
