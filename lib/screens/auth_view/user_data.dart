import 'package:flutter/material.dart';
import 'package:my_campus/screens/home_scr.dart';
import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/textfield.dart';

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
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(width: 200, child: Image.asset("assets/img/ai.png")),
                  MyTextField(
                      controller: name, label: 'Name', hintText: "Atin Sharma"),
                  MyTextField(
                      controller: rollNo,
                      label: 'Roll Number',
                      hintText: "2204221520010"),
                  MyTextField(controller: year, label: 'Year', hintText: "3rd"),
                  MyTextField(
                      controller: branch, label: 'Branch', hintText: "CSE(AI)"),
                  MyTextField(label: 'Mobile Number', hintText: "7905539159"),
                  SizedBox(
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
                              Map<String, dynamic> data = {
                                'Name': name.text,
                                'Roll NO': rollNo.text,
                              };

                              FireStoreService.instance
                                  .collection('Users')
                                  .add(data);
                              //wapas screen pr nhi aa
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (Route<dynamic> route) =>
                                    false, // This condition removes all previous routes.
                              );
                              //  addUser();
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

  // void addUser() async {
  //   log("entee");
  //   FocusManager.instance.primaryFocus!.unfocus();
  //   Map<String, dynamic> users = {
  //     "userName": name.text,
  //     // "Roll NO": rollNo.text,
  //     // // "age": int.parse(ageController.text.trim()),
  //     // "year": year,
  //     // "Branch": branch,
  //   };
  //   log("befor adding user:");

  //   Map? res = await FireStoreService.addUser(users);
  //   log("add");
  //   if (res == null) {
  //     log("after addig error addd ni hua");
  //   }

  //   log("after adding:" + addUser.toString());
  //   successMessage("Successfully Updated,");
  //   setState(() {
  //     name.clear();
  //     // rollNo.clear();
  //     // year.clear();
  //     // branch.clear();
  //   });
  //   log('data: $users');
  // }
}
