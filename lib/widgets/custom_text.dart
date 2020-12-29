import 'package:flutter/material.dart';
import 'package:student_services/utility/constans.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign align;

  const MyText(
      {Key key,
      @required this.text,
      this.size,
      this.color,
      this.weight,
      this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        fontSize: size ?? 16,
        color: color ?? black,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}
