import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_services/models/order_model.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/my_text.dart';

class LevelThree extends StatefulWidget {
  @override
  _LevelThreeState createState() => _LevelThreeState();
}

class _LevelThreeState extends State<LevelThree> {
  @override
  Widget build(BuildContext context) {
    Query levelThree = StudentServicesApp.firebaseFirestore
        .collection('orders')
        .where('bookLevel', isEqualTo: 'level 3')
        .orderBy('time', descending: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: MyText(
          text: 'Level 3',
          size: 20,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: levelThree.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              Order order = Order.fromJson(snapshot.data.docs[index].data());
              return ListTile(
                title: MyText(
                  text: order.customerName,
                  align: TextAlign.start,
                ),
                subtitle: Text(order.bookTitle),
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
