import 'package:expense_tracker_app/screen/home_screen.dart';
import 'package:flutter/material.dart';

Color kTextColor1 = const Color.fromARGB(255, 16, 1, 42);
Color kTextColor2 = const Color.fromARGB(255, 255, 255, 255);
Color kTextColor3 = const Color.fromARGB(255, 182, 157, 222);
Color kShadowColor = const Color.fromARGB(255, 61, 61, 62);
Color kDisableButton = const Color.fromARGB(255, 203, 203, 203);
Color kBgColor1 = const Color.fromARGB(255, 221, 207, 244);
Color kBgColor2 = const Color.fromARGB(255, 16, 1, 42);
Color kIconColor = const Color.fromARGB(255, 63, 13, 151);

void main() {
  runApp(const MaterialApp(
      home: HomeScreen(),
    ));
}
