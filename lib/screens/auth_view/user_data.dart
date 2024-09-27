import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/textfield.dart';
import 'package:my_campus/widget/toast_msg.dart';

class UserDataScr extends StatefulWidget {
  const UserDataScr({super.key});

  @override
  State<UserDataScr> createState() => _UserDataScrState();
}

class _UserDataScrState extends State<UserDataScr> {
  TextEditingController name = TextEditingController();
  TextEditingController rollNo = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController parents = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Method to update a user
  Future<void> updateUser(String documentId, Map<String, dynamic> data) {
    return _db.collection('users').doc(documentId).update(data);
  }

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
                  // SizedBox(width: 200, child: Image.asset("assets/img/ai.png")),
                  const SizedBox(
                    height: 50,
                  ),
                  MyTextField(
                      controller: name, label: 'Name', hintText: "Atin Sharma"),
                  MyTextField(
                      controller: rollNo,
                      label: 'Roll Number',
                      hintText: "2204221520010"),
                  MyTextField(
                      controller: branch, label: 'Branch', hintText: "CSE(AI)"),
                  MyTextField(controller: year, label: 'Year', hintText: "3rd"),

                  MyTextField(
                      controller: number,
                      label: 'Mobile Number',
                      hintText: "7905539159"),
                  MyTextField(
                      controller: parents,
                      label: 'Parents Number',
                      hintText: "7905539159"),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: FloatingActionButton(
                            backgroundColor: Colors.grey,
                            child: const Text(
                              "Submit",
                              style: kLabelTextStyle,
                            ),
                            onPressed: () {
                              addUser();
                            }),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addUser() async {
    FocusManager.instance.primaryFocus!.unfocus();

    Map<String, dynamic> users = {
      "Name": name.text,
      "Roll No.": rollNo.text,
      "Year": year.text,
      "Branch": branch.text,
      "Number": number.text,
      "ParentsNo": parents.text,
      "userId": auth.currentUser!.uid,
    };
    log("befor adding user:");

    Map? res = await FireStoreService.addUser(users);
    if (res == null) {
      log("after addig error addd ni hua");
    }

    log("after adding:" + addUser.toString());
    successMessage("Successfully Updated,");
    setState(() {
      name.clear();
      rollNo.clear();
      year.clear();
      branch.clear();
      number.clear();
      parents.clear();
    });
    log('data: $users');
  }
}
