import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/widget/app_button.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/textfield.dart';
import 'package:my_campus/widget/toast_msg.dart';

class ForgetScr extends StatefulWidget {
  const ForgetScr({super.key});

  @override
  State<ForgetScr> createState() => _ForgetScrState();
}

class _ForgetScrState extends State<ForgetScr> {
  MainController controller = Get.find();
  final TextEditingController email = TextEditingController();

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
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    FadeInUp(
                        duration: Duration(milliseconds: 1800),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          height: screenHeight * 0.22,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              // border:
                              //     Border.all(width: 2, color: kprimaryColors),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(94, 239, 140, 0.839),
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
                                  FadeInUp(
                                      duration: Duration(milliseconds: 1800),
                                      child: AppButton(
                                        hint: "Send",
                                        onPressed: () {
                                          if (validate()) {
                                            controller
                                                .forgetPassword(email.text);
                                          }
                                        },
                                      )),
                                ],
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

  bool validate() {
    if (email.text.isEmpty) {
      showToastMessage('Please enter email.');
      return false;
    }
    return true;
  }

//back gorund decoration
  Container Backgroundview() {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/png/background.png'),
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
                      "Forget Password!",
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
