import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_campus/screens/home_scr.dart';

class SplashScr extends StatefulWidget {
  const SplashScr({super.key});

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> {
  @override
    @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png'), // Add your logo here
            SizedBox(height: 20),
            CircularProgressIndicator(), // Optional: Show a loading indicator
          ],
        ),
      ),
    );
  }
}