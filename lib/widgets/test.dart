import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot myData = snapshot.data.docs[index];
              return ListTile(
                title: Text(myData['firstName']),
                subtitle: Text(myData['lastName']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    myData.reference.delete();
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
