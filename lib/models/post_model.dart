import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student_services/utility/config.dart';

class Post {
  String title;
  String description;
  String userFirstName;
  String userLastName;
  String postImage;
  String userUID;
  Timestamp time;

  Post(
      {this.title,
      this.userFirstName,
      this.userLastName,
      this.description,
      this.postImage,
      this.time,
      this.userUID});

  Post.fromJson(Map<String, dynamic> json) {
    title = json['postTitle'];
    description = json['postDescription'];
    userFirstName = json['userFirstName'];
    userLastName = json['userLastName'];
    postImage = json['postImage'];
    userUID = json['userUID'];
    time = json['time'];
  }

  Future getUserPostsFuture() async {
    var uid = await StudentServicesApp.auth.currentUser.uid;

    await StudentServicesApp.firebaseFirestore
        .collection('posts')
        .doc(uid)
        .get()
        .then((result) {
      title = result['postTitle'];
      description = result['postDescription'];
      userFirstName = result['userFirstName'];
      userLastName = result['userLastName'];
      postImage = result['postImage'];
      userUID = result['userUID'];
      time = result['time'];
    });
  }

  Future getAllPostsFuture() async {
    StudentServicesApp.firebaseFirestore
        .collection('posts')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(doc["postTitle"]);
              })
            });
  }

  Future getposts() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("posts").get();
    return qn.docs;
  }
}
