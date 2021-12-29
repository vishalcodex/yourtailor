import 'package:flutter/material.dart';

const Color kPrimaryCardColor = const MaterialColor(0xFF00008B, const <int, Color>{
  50: const Color(0xFFE0F2F1),
  100: const Color(0xFFA7FFEB),
  200: const Color(0xFF80CBC4),
  300: const Color(0xFF4DB6AC),
  400: const Color(0xFF1DE9B6),
  500: const Color(0xFF009688),
  600: const Color(0xFF00897B),
  700: const Color(0xFF00BFA5),
  800: const Color(0xFF00695C),
  900: const Color(0xFF32154E),
},);

TextStyle kStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

const kInputStyle = InputDecoration(
  border: OutlineInputBorder(),
);

const Color kPrimaryColor = Color(0xfffe5f55);
const Color kSecondPrimaryColor = Color(0xffe01e37);
const Color kPrimaryAccentColor = Color(0xfff87060);
const Color kSecondaryColor = Color(0xff102542);
const Color kTextDarkColor = Color(0xff000000);
const TextStyle kTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0
);

const TextStyle kBusinessTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0
);

const TextStyle kHeadingTextStyle = TextStyle(
    color: Colors.black54,
    fontSize: 18.0
);
const TextStyle kContentTextStyle = TextStyle(
    color: Colors.black87,
    fontSize: 16.0
);
const String appName = 'Your Tailor';
const String apiUrl = "https://tailernew.codextechnologies.co.in/public/";
const String imagesUrl = "https://tailernew.codextechnologies.co.in/public/images/";

RegExp emailValidation = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");