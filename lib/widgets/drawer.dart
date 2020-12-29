import 'dart:async';
import 'package:flutter/material.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/custom_text.dart';
import 'package:student_services/models/users.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isAdmin;
  Users users = Users();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  currentAccountPicture: Container(
                    alignment: Alignment.center,
                    child: MyText(
                      text: 'MF',
                      color: Colors.white,
                      size: 24,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: mainColor,
                  ),
                  accountName: MyText(
                    text: 'moatz'.toUpperCase(),
                    size: 15,
                    color: Colors.white,
                    weight: FontWeight.w700,
                  ),
                  accountEmail: MyText(
                    text: 'moatz@moatz.com',
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('Help and Feedback'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('Change Password'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'SignIn');
                    signOut();
                  },
                  child: ListTile(
                    title: Text('Sign Out'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // This container holds the align

          FutureBuilder(
            future: users.getUsereData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                _isAdmin = users.admin ?? false;
                return adminFeature();
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
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
                Divider(),
                InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'DoctorPanal');
                  },
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    title: Text(
                      'Doctor Panal',
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
        alignment: Alignment.center,
        child: MyText(
          text: 'You are\'t a doctor',
          color: mainColor,
        ),
      );
    }
  }
}
