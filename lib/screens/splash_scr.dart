
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class SplashScr extends StatefulWidget {
  const SplashScr({super.key});

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> {
 
  // void initState() {
  //   super.initState();
  //   Timer(Duration(seconds: 3), () {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => RegisterScr()),
  //     );
  //   });
  // }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColors,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(60, 26, 85, 109),
            Color.fromARGB(255, 21, 236, 229)
          ],
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeInDown(
                duration: const Duration(milliseconds: 1800),
                child: SizedBox(
                    height: 400,
                    width: 400,
                    child: Image.asset('assets/img/name.png')),
              ), // Add your logo here

              FadeInUp(
                child: Text(
                  "AI CAMPUS",
                  style: TextStyle(
                      letterSpacing: 20,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
              // CircularProgressIndicator(), // Optional: Show a loading indicator
            ],
          ),
        ),
      ),
    );
  }
}
