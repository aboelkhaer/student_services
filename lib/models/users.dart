import 'package:student_services/utility/config.dart';

class Users {
  String id;
  String firstName;
  String lastName;
  String url;
  bool lib;
  String phone;
  String email;
  bool admin;
  String aboutMe;
  String doctorHomeImage;

  Users(
      {this.admin,
      this.firstName,
      this.id,
      this.email,
      this.lib,
      this.lastName,
      this.aboutMe,
      this.doctorHomeImage,
      this.phone,
      this.url});

  Users.fromJson(Map data) {
    id = data['uid'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    phone = data['phone'];
    lib = data['lib'];
    doctorHomeImage = data['doctorHomeImage'];
    email = data['email'];
    url = data['url'];
    aboutMe = data['aboutMe'];
    admin = data['admin'];
  }

  getUsereData() async {
    var uid = StudentServicesApp.auth.currentUser.uid;

    await StudentServicesApp.firebaseFirestore
        .collection('users')
        .doc(uid)
        .get()
        .then((result) {
      admin = result['admin'];
      id = result['uid'];
      firstName = result['firstName'];
      lastName = result['lastName'];
      phone = result['phone'];
      email = result['email'];
      lib = result['lib'];
      url = result['url'];
    });
  }
}
