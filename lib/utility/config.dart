import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentServicesApp {
  static SharedPreferences sharedPreferences;
  static User user;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static final String userFirstName = 'firstName';
  static final String userUID = 'uid';
  static final String userLastName = 'lastName';
  static final String userAdmin = 'admin';
  static final String userPhone = 'phone';
  static final String userEmail = 'email';
  static final String userPhotoUrl = 'url';
}
