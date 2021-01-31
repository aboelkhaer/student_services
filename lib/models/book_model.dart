import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_services/utility/config.dart';

class Book {
  String title,
      level,
      description,
      term,
      userUID,
      userFirstName,
      price,
      userLastName,
      bookImageUrl;
  Timestamp time;

  Book({
    this.title,
    this.level,
    this.term,
    this.userUID,
    this.price,
    this.description,
    this.userFirstName,
    this.userLastName,
    this.bookImageUrl,
    this.time,
  });
  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    description = json['description'];
    level = json['bookLevel'];
    term = json['bookTerm'];
    userUID = json['userUID'];
    userFirstName = json['userFirstName'];
    userLastName = json['userLastName'];
    bookImageUrl = json['bookImageUrl'];
    time = json['time'];
  }
//    getBookCount() async {
//     var uid = StudentServicesApp.auth.currentUser.uid;

//     await StudentServicesApp.firebaseFirestore
//         .collection('orders')
//         .doc(uid)
//         .get()
//         .then((result) {
//       admin = result['admin'];
//       id = result['uid'];
//       firstName = result['firstName'];
//       lastName = result['lastName'];
//       phone = result['phone'];
//       email = result['email'];
//       lib = result['lib'];
//       url = result['url'];
//     });
//   }
// }

}
