import 'package:flutter/material.dart';

class AsignmentScr extends StatefulWidget {
  const AsignmentScr({super.key});

  @override
  State<AsignmentScr> createState() => _AsignmentScrState();
}

class _AsignmentScrState extends State<AsignmentScr> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Center(child: Text("Work on progress",style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),))],),);

  }
}