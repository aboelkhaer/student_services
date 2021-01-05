import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_services/models/post_model.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/my_text.dart';

class ShowPosts extends StatefulWidget {
  @override
  _ShowPostsState createState() => _ShowPostsState();
}

class _ShowPostsState extends State<ShowPosts> {
  @override
  Widget build(BuildContext context) {
    var uid = StudentServicesApp.auth.currentUser.uid;
    Query posts = FirebaseFirestore.instance
        .collection('posts')
        .where('userUID', isEqualTo: uid)
        .orderBy('time', descending: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: MyText(
          text: 'Your Posts',
          size: 20,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: posts.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              Post post = Post.fromJson(snapshot.data.docs[index].data());
              return ListTile(
                title: Text(post.title),
                subtitle: Text(
                  post.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    snapshot.data.docs[index].reference.delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
