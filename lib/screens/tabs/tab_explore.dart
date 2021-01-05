import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:student_services/models/post_model.dart';
import 'package:student_services/screens/details/post_details.dart';
import 'package:student_services/utility/capitalize.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/utility/time_function.dart';
import 'package:student_services/widgets/my_text.dart';

class ExploreTab extends StatefulWidget {
  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  @override
  Widget build(BuildContext context) {
    Query myPosts = StudentServicesApp.firebaseFirestore
        .collection('posts')
        .orderBy('time', descending: true);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: StreamBuilder<QuerySnapshot>(
        stream: myPosts.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            addAutomaticKeepAlives: true,
            padding: EdgeInsets.only(top: 8, bottom: 40),
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              Post post = Post.fromJson(snapshot.data.docs[index].data());
              return Column(
                children: [
                  postBody(post, context),
                ],
              );
              // DocumentSnapshot myData = snapshot.data.docs[index];
              // return ListTile(
              //   title: Text(myData.data()['postTitle']),
              //   subtitle: Text(myData.data()['postDescription']),
              // );
            },
          );
        },
      ),
    );
  }

  Widget postBody(Post post, BuildContext context) {
    String uid = StudentServicesApp.auth.currentUser.uid;
    var size = MediaQuery.of(context).size;
    var time =
        DateTime.fromMillisecondsSinceEpoch(post.time.millisecondsSinceEpoch);
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 8),
      height: size.height * 0.2,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.5),
      ),
      child: Card(
        elevation: 3,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostDetails(
                          post: post,
                        )));
          },
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 50,
                        height: 50,
                        child: FutureBuilder(
                          future: _getUserProfileImage(context, uid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: snapshot.data == null
                                        ? AssetImage('assets/images/avatar.png')
                                        : snapshot.data,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
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
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text:
                              'Dr. ${capitalize(post.userFirstName)} ${capitalize(post.userLastName)}',
                          size: 17,
                          weight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        MyText(
                          text: displayTimeAgoFromTimestamp(time.toString()),
                          align: TextAlign.start,
                          size: 13.5,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 3),
                  child: Divider(
                    thickness: 0.5,
                    color: mainColor,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        post.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
}

class FireStoreService extends ChangeNotifier {
  FireStoreService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
