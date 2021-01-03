import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_services/utility/capitalize.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
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
  double drawerTextSize = 15.3;

  @override
  Widget build(BuildContext context) {
    var uid = StudentServicesApp.auth.currentUser.uid;
    Future<DocumentSnapshot> myInfo =
        FirebaseFirestore.instance.collection('users').doc(uid).get();

    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  currentAccountPicture: Container(
                    alignment: Alignment.center,
                    child: FutureBuilder(
                        future: myInfo,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return MyText(
                              text:
                                  '${snapshot.data['firstName'][0].toUpperCase()}${snapshot.data['lastName'][0].toUpperCase()}',
                              color: Colors.white,
                              weight: FontWeight.bold,
                              size: 24,
                            );
                          } else {
                            return Container();
                          }
                        }),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage('assets/images/drawer.jpg'),
                        fit: BoxFit.cover),
                  ),
                  accountName: FutureBuilder(
                      future: myInfo,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return MyText(
                            text:
                                '${capitalize(snapshot.data['firstName'])} ${capitalize(snapshot.data['lastName'])}',
                            size: 20,
                            color: Colors.white,
                            weight: FontWeight.w700,
                          );
                        } else {
                          return Container();
                        }
                      }),
                  accountEmail: FutureBuilder(
                      future: myInfo,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return MyText(
                            text: snapshot.data['email'],
                            color: Colors.white,
                            size: 14,
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
                // accountInDrawer(

                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: 'Soon.');
                  },
                  child: ListTile(
                    title: MyText(
                      size: drawerTextSize,
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
                      size: drawerTextSize,
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
                      size: drawerTextSize,
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
                      size: drawerTextSize,
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
                      size: drawerTextSize,
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
                      size: drawerTextSize,
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

  // readFromSharedPref() async {
  //   StudentServicesApp.sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   firstName = StudentServicesApp.sharedPreferences
  //       .getString(StudentServicesApp.userFirstName);
  //   lastName = StudentServicesApp.sharedPreferences
  //       .getString(StudentServicesApp.userLastName);
  //   email = StudentServicesApp.sharedPreferences
  //       .getString(StudentServicesApp.userEmail);
  // }

  Future signOut() async {
    try {
      return await StudentServicesApp.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

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
                    Navigator.popAndPushNamed(context, 'Dashboard');
                  },
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: mainColor,
                      size: 20,
                    ),
                    title: MyText(
                      text: 'Dashboard',
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
