import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  bool _isLib;
  Users users = Users();
  // String firstName = '';
  // String lastName = '';
  // String email = '';
  double drawerTextSize = 15.0;
//   Future getUserImage() async {
//     final imageUrl = await imageLink.getDownloadUrl();
// Image.network(imageUrl.toString());
//   }

  @override
  Widget build(BuildContext context) {
    var uid = StudentServicesApp.auth.currentUser.uid;
    Future<DocumentSnapshot> myInfo =
        FirebaseFirestore.instance.collection('users').doc(uid).get();
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                //Drawer head
                Container(
                  padding: EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 14,
                    bottom: 14,
                  ),
                  height: size.height * 0.23,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/drawer.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 70,
                          height: 70,
                          child: FutureBuilder(
                            future: _getUserProfileImage(context, uid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  snapshot.connectionState ==
                                      ConnectionState.active ||
                                  snapshot.connectionState ==
                                      ConnectionState.none) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: snapshot.data == null
                                          ? AssetImage(
                                              'assets/images/avatar.png')
                                          : snapshot.data,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  // child: snapshot.data == null
                                  //     ? Image(
                                  //         image: ExactAssetImage(
                                  //             'assets/images/avatar.png'),
                                  //         fit: BoxFit.cover,
                                  //       )
                                  //     : Image.network(
                                  //         snapshot.data,
                                  //         fit: BoxFit.cover,
                                  //         errorBuilder: (BuildContext context,
                                  //             Object exception,
                                  //             StackTrace stackTrace) {
                                  //           return Image(
                                  //             image: ExactAssetImage(
                                  //                 'assets/images/avatar.png'),
                                  //             fit: BoxFit.cover,
                                  //           );
                                  //         },
                                  //       ),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  child: CircularProgressIndicator(),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: myInfo,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return MyText(
                                text:
                                    '${capitalize(snapshot.data['firstName'])} ${capitalize(snapshot.data['lastName'])}',
                                size: 18,
                                color: Colors.white,
                                weight: FontWeight.w700,
                              );
                            } else {
                              return Container();
                            }
                          }),
                      FutureBuilder(
                          future: myInfo,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return MyText(
                                text: snapshot.data['email'],
                                color: Colors.white,
                                size: 15,
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ],
                  ),
                ),

                //Drawer body

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
                    Navigator.popAndPushNamed(context, 'StudentBooks');
                  },
                  child: ListTile(
                    title: MyText(
                      size: drawerTextSize,
                      text: 'Your Books',
                      weight: FontWeight.bold,
                      align: TextAlign.start,
                    ),
                    leading: Icon(
                      Icons.bookmark,
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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Some thing went error.'),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                _isLib = users.lib ?? false;
                return libFeature();
              } else {
                return SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          FutureBuilder(
            future: users.getUsereData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Some thing went error.'),
                );
              }

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

  _getUserProfileImage(BuildContext context, String imageName) async {
    NetworkImage image;
    await FireStoreService.loadImage(context, imageName).then((value) {
      image = NetworkImage(value.toString());
    });
    return image;
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
                      text: 'Doctor Side',
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

  Widget libFeature() {
    if (_isLib == true) {
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
                    Navigator.popAndPushNamed(context, 'LibarianScreen');
                  },
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: mainColor,
                      size: 20,
                    ),
                    title: MyText(
                      text: 'Libarian Side',
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
          text: 'You need access to go to libarian side.',
          color: mainColor,
        ),
      );
    }
  }
}

class FireStoreService extends ChangeNotifier {
  FireStoreService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
