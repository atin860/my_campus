import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_campus/screens/auth_view/forget_scr.dart';
import 'package:my_campus/screens/auth_view/register_scr.dart';
import 'package:my_campus/widget/app_button.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/textfield.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({super.key});

  @override
  State<LoginScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
         onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Backgroundview(),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    FadeInUp(
                        duration: const Duration(milliseconds: 1800),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          height: screenHeight * 0.22,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(width: 2, color: kprimaryColors),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(94, 171, 239, 0.842),
                                    blurRadius: 30.0,
                                    offset: Offset(0, 20))
                              ]),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  MyTextField(
                                      label: "Email",
                                      hintText: "biet14@gmail.com"),
                                  MyTextField(
                                    label: "Password",
                                    hintText: "biet@123",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1800),
                        child: AppButton(
                          hint: "Login",
                          onPressed: () {},
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 2000),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.to(() => const RegisterScr());
                                },
                                child: const Text(
                                  "Create Account",
                                  style: TextStyle(color: kprimaryColors),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => const ForgetScr());
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: kprimaryColors),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

// this is background backview decoartion
  Container Backgroundview() {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/background.png'),
              fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 30,
            width: 80,
            height: 200,
            child: FadeInUp(
                duration: const Duration(seconds: 1),
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/img/light-1.png'))),
                )),
          ),
          Positioned(
            left: 140,
            width: 80,
            height: 150,
            child: FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/img/light-2.png'))),
                )),
          ),
          Positioned(
            right: 40,
            top: 40,
            width: 80,
            height: 150,
            child: FadeInUp(
                duration: const Duration(milliseconds: 1300),
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/img/clock.png'))),
                )),
          ),
          Positioned(
            child: FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: const Center(
                    child: Text(
                      "Welcome Back!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
