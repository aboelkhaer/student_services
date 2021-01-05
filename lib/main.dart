import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_services/screens/details/post_details.dart';
import 'package:student_services/screens/doctor_screens/add_book.dart';
import 'package:student_services/screens/doctor_screens/add_post.dart';
import 'package:student_services/screens/doctor_screens/dashboard.dart';
import 'package:student_services/screens/doctor_screens/show_books.dart';
import 'package:student_services/screens/doctor_screens/show_posts.dart';
import 'package:student_services/screens/signin.dart';
import 'package:student_services/screens/signup.dart';
import 'package:student_services/screens/welcome_screen.dart';
import 'package:student_services/screens/home_screen.dart';
import 'package:student_services/utility/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/screens/change_password.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  StudentServicesApp.sharedPreferences = await SharedPreferences.getInstance();

  bool seen = StudentServicesApp.sharedPreferences.getBool('seen');
  StudentServicesApp.user = await FirebaseAuth.instance.currentUser;
  Widget _screen;
  if (seen == null || seen == false) {
    _screen = WelcomeScreen();
  } else if (seen == true && StudentServicesApp.user == null) {
    _screen = SignIn();
  } else {
    _screen = HomeScreen();
  }

  runApp(StudentsServices(_screen));
}

class StudentsServices extends StatelessWidget {
  final Widget _screen;
  StudentsServices(this._screen);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        title: 'Students Services',
        home: this._screen,
        routes: {
          'SignIn': (context) => SignIn(),
          'SignUp': (context) => SignUp(),
          'HomeScreen': (context) => HomeScreen(),
          'ChangePassword': (context) => ChangePasswordScreen(),
          'Dashboard': (context) => Dashboard(),
          'AddPost': (context) => AddPost(),
          'ShowPosts': (context) => ShowPosts(),
          'PostDetails': (context) => PostDetails(),
          'AddBook': (context) => AddBook(),
          'ShowBooks': (context) => ShowBooks(),
        },
      ),
    );
  }
}
