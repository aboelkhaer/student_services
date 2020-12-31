import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_services/utility/capitalize.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/account_in_drawer.dart';
import 'package:student_services/widgets/my_text.dart';
import 'package:student_services/models/users.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isAdmin;
  Users users = Users();
  String firstName = '';
  String lastName = '';
  String email = '';

  @override
  void initState() {
    readFromSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                FutureBuilder(
                    future: readFromSharedPref(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return accountInDrawer(
                          MyText(
                            text:
                                '${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}',
                            color: Colors.white,
                            weight: FontWeight.bold,
                            size: 24,
                          ),
                          MyText(
                            text:
                                '${capitalize(firstName)} ${capitalize(lastName)}',
                            size: 20,
                            color: Colors.white,
                            weight: FontWeight.w700,
                          ),
                          MyText(
                            text: email,
                            color: Colors.white,
                            size: 14,
                          ),
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        );
                      }
                    }),
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: 'Soon.');
                  },
                  child: ListTile(
                    title: MyText(
                      size: 15.5,
                      text: 'Support Us',
                      align: TextAlign.start,
                      weight: FontWeight.bold,
                    ),
                    leading: Icon(
                      Icons.favorite,
                      color: mainColor,
                      size: 22,
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.18,
                  color: mainColor,
                ),
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: 'Soon.');
                  },
                  child: ListTile(
                    title: MyText(
                      size: 15.5,
                      text: 'Help And Feedback',
                      align: TextAlign.start,
                      weight: FontWeight.bold,
                    ),
                    leading: Icon(
                      Icons.help,
                      color: mainColor,
                      size: 22,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: 'Soon.');
                  },
                  child: ListTile(
                    title: MyText(
                      size: 15.5,
                      text: 'Share App',
                      align: TextAlign.start,
                      weight: FontWeight.bold,
                    ),
                    leading: Icon(
                      Icons.share,
                      color: mainColor,
                      size: 22,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: MyText(
                      size: 15.5,
                      text: 'Who Us?',
                      align: TextAlign.start,
                      weight: FontWeight.bold,
                    ),
                    leading: Icon(
                      Icons.person,
                      color: mainColor,
                      size: 22,
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.18,
                  color: mainColor,
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: MyText(
                      size: 15.5,
                      text: 'Change Password',
                      weight: FontWeight.bold,
                      align: TextAlign.start,
                    ),
                    leading: Icon(
                      Icons.lock,
                      color: mainColor,
                      size: 22,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'SignIn');
                    signOut();
                  },
                  child: ListTile(
                    title: MyText(
                      size: 15.5,
                      text: 'Sign Out',
                      weight: FontWeight.bold,
                      align: TextAlign.start,
                    ),
                    leading: Icon(
                      Icons.exit_to_app,
                      color: mainColor,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // This container holds the align
          // This function for defference between doctors and students
          FutureBuilder(
            future: users.getUsereData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                _isAdmin = users.admin ?? false;
                return adminFeature();
              } else {
                return SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  readFromSharedPref() async {
    StudentServicesApp.sharedPreferences =
        await SharedPreferences.getInstance();
    firstName = StudentServicesApp.sharedPreferences
        .getString(StudentServicesApp.userFirstName);
    lastName = StudentServicesApp.sharedPreferences
        .getString(StudentServicesApp.userLastName);
    email = StudentServicesApp.sharedPreferences
        .getString(StudentServicesApp.userEmail);
  }

  Future signOut() async {
    try {
      return await StudentServicesApp.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // _getProfileData() async {
  //   var uid = await StudentServicesApp.auth.currentUser.uid;

  //   await StudentServicesApp.firebaseFirestore
  //       .collection('users')
  //       .doc(uid)
  //       .get()
  //       .then((result) {
  //     users.admin = result['admin'];
  //   });
  // }

  Widget adminFeature() {
    if (_isAdmin == true) {
      return Container(
        alignment: Alignment.center,
        // This align moves the children to the bottom
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          // This container holds all the children that will be aligned
          // on the bottom and should not scroll with the above ListView
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                // Divider(),
                InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'DoctorPanal');
                  },
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: mainColor,
                      size: 20,
                    ),
                    title: MyText(
                      text: 'Doctor Panal',
                      color: mainColor,
                      weight: FontWeight.w500,
                      align: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(bottom: 16),
        alignment: Alignment.center,
        child: MyText(
          size: 14,
          text: 'You need access to go to doctors side.',
          color: mainColor,
        ),
      );
    }
  }
}
