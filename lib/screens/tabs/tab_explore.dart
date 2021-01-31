import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_services/models/post_model.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/widgets/posts_body.dart';

class ExploreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query myPosts = StudentServicesApp.firebaseFirestore
        .collection('posts')
        .orderBy('time', descending: true);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: FutureBuilder<QuerySnapshot>(
        future: myPosts.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Some thing went error.'),
            );
          }

          return ListView.builder(
            addAutomaticKeepAlives: true,
            padding: EdgeInsets.only(top: 8, bottom: 40),
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              Post post = Post.fromJson(snapshot.data.docs[index].data());
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data.docs == null) {
                return CircularProgressIndicator();
              }
              return Column(
                children: [
                  postBody(post, context),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
