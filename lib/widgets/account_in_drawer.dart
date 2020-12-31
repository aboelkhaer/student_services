import 'package:flutter/material.dart';

Widget accountInDrawer(Widget shortcut, Widget name, Widget email) {
  return UserAccountsDrawerHeader(
    currentAccountPicture: Container(
      alignment: Alignment.center,
      child: shortcut,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
    ),
    decoration: BoxDecoration(
      image: DecorationImage(
          image: ExactAssetImage('assets/images/drawer.jpg'),
          fit: BoxFit.cover),
    ),
    accountName: name,
    accountEmail: email,
  );
}

//  MyText(
//       text: '${users.firstName}',
//       size: 15,
//       color: Colors.white,
//       weight: FontWeight.w700,
//     ),

// MyText(
//      text: '${users.email}',
//       color: Colors.white,
//       size: 14,
//     )

// MyText(
//         '${users.firstName[0].toUpperCase()}${users.lastName[0].toUpperCase()}',
//         color: Colors.white,
//         size: 24,
//       ),
