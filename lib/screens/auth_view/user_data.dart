import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_campus/screens/auth_view/login_scr.dart';
import 'package:my_campus/screens/home_scr.dart';
import 'package:my_campus/widget/app_button.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/textfield.dart';

class UserDataScr extends StatefulWidget {
  const UserDataScr({super.key});

  @override
  State<UserDataScr> createState() => _UserDataScrState();
}

class _UserDataScrState extends State<UserDataScr> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      child: Scaffold(
        appBar: AppBar(
          leading: const Image(
              //   height: 50,width: 50,
              image: AssetImage(
            "assets/img/name.png",
          )),
          backgroundColor: Colors.grey,
          title: const Text(
            "WelCome User!",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              
              child: Column(
                children: [
                  SizedBox(
                      //  height: 250,
                      width: 200,
                      child: Image.asset("assets/img/ai.png")),
                     // SizedBox(height: 10,),
                  const MyTextField(label: 'Name', hintText: "Atin Sharma"),
                  const MyTextField(label: 'Roll Number', hintText: "2204221520010"),
                  const MyTextField(label: 'Year', hintText: "3rd"),
                  const MyTextField(label: 'Branch', hintText: "CSE(AI)"),
                  const MyTextField(label: 'Mobile Number', hintText: "7905539159"),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 50,width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: FloatingActionButton(
                        backgroundColor: Colors.grey,
                        child: const Text("Submit",style: kLabelTextStyle,),
                        onPressed: (){Get.to(()=>HomeScreen());}),
                    ))
                  
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
