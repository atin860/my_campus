import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class MyAppbar extends StatelessWidget {
  const MyAppbar({super.key, required this.name});
final String name;
  @override
  Widget build(BuildContext context) {
    return  AppBar(
        backgroundColor: kBackgroundColors,
        title: Center(child: Text(name,style: kappbarTextStyle,)),);
  }
}