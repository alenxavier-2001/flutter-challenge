import 'package:flutter/material.dart';

Widget mediumText(String data, double width, Color color) {
  return Text(
    data,
    style: TextStyle(
        color: color, fontSize: width / 22, fontWeight: FontWeight.w600),
  );
}
