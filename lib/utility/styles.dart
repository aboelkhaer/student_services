import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constans.dart';

TextStyle authText = TextStyle(
  color: Colors.black,
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

InputDecoration textFormDecoration(
  String text,
) {
  return InputDecoration(
    hintText: text,
    helperMaxLines: 1,
    hintStyle: TextStyle(color: Colors.grey),
    filled: true,
    fillColor: textFormColor,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide.none,
    ),
  );
}
