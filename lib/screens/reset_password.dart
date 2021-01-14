import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/utility/styles.dart';
import 'package:student_services/widgets/my_text.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  TextEditingController _userEmailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _userEmailController.dispose();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: MyText(
          text: 'Reset password',
          size: 18,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                        return value.length > 0 ? null : 'Email is empty';
                      },
                      controller: _userEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: textFormDecoration('Email'),
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
                          text: 'Send Password',
                          color: Colors.white,
                          weight: FontWeight.bold,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            StudentServicesApp.auth.sendPasswordResetEmail(
                                email: _userEmailController.text);
                            Navigator.pop(context);

                            Fluttertoast.showToast(
                                msg: 'Check your mail.',
                                textColor: Colors.green);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
