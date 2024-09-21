import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class NotesScr extends StatefulWidget {
  const NotesScr({super.key});

  @override
  State<NotesScr> createState() => _NotesScrState();
}

class _NotesScrState extends State<NotesScr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: kBackgroundColors,
        title: Center(child: Text("Notes",style: kappbarTextStyle,)),),
    );
  }
}