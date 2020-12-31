import 'package:student_services/utility/config.dart';

class Users {
  String id;
  String firstName;
  String lastName;
  String url;
  String phone;
  String email;
  bool admin;

  Users(
      {this.admin,
      this.firstName,
      this.id,
      this.email,
      this.lastName,
      this.phone,
      this.url});

  Users.fromJson(Map data) {
    id = data['uid'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    phone = data['phone'];
    email = data['email'];
    url = data['url'];
    admin = data['admin'] ?? false;
  }

  getUsereData() async {
    var uid = await StudentServicesApp.auth.currentUser.uid;

    await StudentServicesApp.firebaseFirestore
        .collection('users')
        .doc(uid)
        .get()
        .then((result) {
      admin = result['admin'];
      id = result['uid'];
      firstName = result['firstName'] ?? 'Non name';
      lastName = result['lastName'] ?? 'Non name';
      phone = result['phone'] ?? 'Non phone';
      email = result['email'] ?? 'None email';
      url = result['url'] ?? 'None url';
    });
  }
}
