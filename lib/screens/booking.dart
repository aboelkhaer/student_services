import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_services/models/book_model.dart';
import 'package:student_services/utility/capitalize.dart';
import 'package:student_services/utility/config.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/utility/styles.dart';
import 'package:student_services/widgets/my_text.dart';

class BookingScreen extends StatefulWidget {
  final Book book;

  const BookingScreen({Key key, this.book}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController _userFullNameController = TextEditingController();
  TextEditingController _userAdressController = TextEditingController();
  TextEditingController _userPhoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userFullNameController.dispose();
    _userAdressController.dispose();
    _userPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: MyText(
          text: 'Booking',
          size: 20,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    return value.length > 0 ? null : 'Full Name is empty';
                  },
                  controller: _userFullNameController,
                  keyboardType: TextInputType.text,
                  decoration: textFormDecoration('Full Name'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    return value.length > 0 ? null : 'Adress is empty';
                  },
                  controller: _userAdressController,
                  keyboardType: TextInputType.text,
                  decoration: textFormDecoration('Adress'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return value.length > 0 ? null : 'Phone is empty';
                  },
                  controller: _userPhoneController,
                  keyboardType: TextInputType.number,
                  decoration: textFormDecoration('Phone'),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 24,
                    left: 16,
                    right: 16,
                  ),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        Fluttertoast.showToast(msg: 'Long press to Booking.');
                      },
                      child: MyText(
                        text: 'Book',
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                      onLongPress: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            _addBookingToDatabase(StudentServicesApp.user);
                            Navigator.of(context).pop();
                            _userFullNameController.text = '';
                            _userAdressController.text = '';
                            _userPhoneController.text = '';
                            Fluttertoast.showToast(
                                msg: 'Done', textColor: Colors.green);
                          } on FirebaseException catch (e) {
                            Fluttertoast.showToast(
                                msg: e.message, textColor: Colors.red);
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Enter data first.');
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _addBookingToDatabase(User fUser) async {
    StudentServicesApp.firebaseFirestore.collection('orders').add({
      'customerName': _userFullNameController.text.trim(),
      'customerAdress': _userAdressController.text.trim(),
      'customerPhone': _userPhoneController.text.trim(),
      'customerUID': fUser.uid,
      'bookTitle': widget.book.title,
      'bookLevel': widget.book.level,
      'bookTerm': widget.book.term,
      'bookAuthor':
          '${capitalize(widget.book.userFirstName)} ${capitalize(widget.book.userLastName)}',
      'authorUID': widget.book.userUID,
      'time': DateTime.now(),
    });
  }
}
// child: Text(widget.book.title),

// IconButton(
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         size: 30,
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
