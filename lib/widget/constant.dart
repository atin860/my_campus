import 'package:flutter/material.dart';
import 'package:text_marquee/text_marquee.dart';

// Main two colors
const kBackgroundColors = Color.fromARGB(255, 65, 131, 211);
const kScaffoldColor = Color.fromARGB(255, 255, 255, 255);
const kprimaryColors = Colors.grey;
const kIconColors = Colors.white;
const kappbarback = Color.fromARGB(255, 255, 169, 21);
const kgradient = LinearGradient(
  colors: [Colors.purple, Colors.blue],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

// for large text heading type
const kLabelTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: Color.fromARGB(255, 255, 255, 255));
// for small container type text
const kcontainerTextStyle =
    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.blue);

// for button text style
const kbuttonTextStyle = TextStyle(fontSize: 20);

const kappbarTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: Color.fromARGB(255, 255, 255, 255));
//for add text
var advText = TextMarquee(
  "This app is developed by Atin Sharma and Team. Contact for more information.",
  rtl: false,
  spaceSize: 30,
  style: TextStyle(color: Colors.red, letterSpacing: 2, fontSize: 13),
);
