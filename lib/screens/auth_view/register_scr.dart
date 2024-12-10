import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/screens/auth_view/login_scr.dart';
import 'package:my_campus/widget/app_button.dart';

import 'package:my_campus/widget/textfield.dart';
import 'package:my_campus/widget/toast_msg.dart';

class RegisterScr extends StatefulWidget {
  const RegisterScr({super.key});

  @override
  State<RegisterScr> createState() => _RegisterScrState();
}

class _RegisterScrState extends State<RegisterScr> {
  MainController controller = Get.find();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

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
                              // image: DecorationImage(
                              //   colorFilter: ColorFilter.linearToSrgbGamma(),
                              //   image: AssetImage("assets/img/back1.jpg"),
                              //   fit: BoxFit.cover,
                              // ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              // border:
                              //Border.all(width: 2, color: kprimaryColors),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(239, 217, 94, 0.839),
                                    blurRadius: 30.0,
                                    offset: Offset(0, 20))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  MyTextField(
                                      controller: email,
                                      label: "Email",
                                      hintText: "biet14@gmail.com"),
                                  MyTextField(
                                    controller: password,
                                    label: "Password",
                                    hintText: "biet@123",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 50),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1800),
                        child: AppButton(
                          hint: "Register",
                          onPressed: () {
                            if (validate()) {
                              controller.signup(email.text, password.text);
                            }
                          },
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: TextButton(
                          onPressed: () {
                            if (validate())
                              controller.login(email.text, password.text);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[600]),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    if (email.text.isEmpty) {
      showToastMessage('Please enter email.');
      return false;
    }
    if (password.text.isEmpty) {
      showToastMessage('Please enter password.');
      return false;
    }
    return true;
  }
}

Container Backgroundview() {
  return Container(
    height: 400,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/png/background.png'), fit: BoxFit.fill)),
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
                        image: AssetImage('assets/png/light-1.png'))),
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
                        image: AssetImage('assets/png/light-2.png'))),
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
                        image: AssetImage('assets/png/clock.png'))),
              )),
        ),
        Positioned(
          child: FadeInUp(
              duration: const Duration(milliseconds: 1600),
              child: Container(
                margin: const EdgeInsets.only(top: 60),
                child: const Center(
                  child: Text(
                    "Register User!",
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
