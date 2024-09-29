import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/service/firebase_storage.dart';
import 'package:my_campus/widget/app_button.dart';
import 'package:my_campus/widget/appbar.dart';
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
  TextEditingController number = TextEditingController();
  final TextEditingController dob = TextEditingController();
   String? selectedBranch;
  String? selectedYear;
  final ImagePicker imgpicker = ImagePicker();
  String? imageUrl;
  File? pickedImage;

  List<String> branches = ['AI', 'AIML'];
  List<String> years = ['2nd Year', '3rd Year', '4th Year'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: kScaffoldColor,
        appBar:const MyAppBar(title: "User Data Form"),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.yellow, width: 5),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: ClipOval(
                        child: pickedImage != null
                            ? Image.file(
                                pickedImage!,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                            : imageUrl != null
                                ? Image.network(
                                    imageUrl!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    frameBuilder:
                                        (_, image, loadingBuilder, __) {
                                      if (loadingBuilder == null) {
                                        return const SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }
                                      return image;
                                    },
                                  )
                                : Image.asset(
                                    "assets/img/atin.jpeg",
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                   Positioned(
                      bottom: 0,
                      right: 5,
                      child: IconButton(
                        onPressed: () {
                          imagePickerOption();
                        },
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    ), 
                    
                  ],
                ),
                const SizedBox(height: 20),
                MyTextField(
                  
                    controller: name, label: 'Name', hintText: "Atin Sharma"),
                MyTextField(
                  keyboardType: TextInputType.number,
                    controller: rollNo,
                    label: 'Roll Number',
                    hintText: "2204221520010"),
                 Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 5,)
               ,   margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 229, 224, 224), 
                  border: Border.all(width: 1,),
                  borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonFormField<String>(
                  value: selectedBranch,
                  hint: const Text('Select Branch'),
                  items: branches.map((String branch) {
                    return DropdownMenuItem<String>(
                      value: branch,
                      child: Text(branch),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBranch = value;
                    });
                  },
                ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 5,)
               ,   margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 229, 224, 224), borderRadius: BorderRadius.circular(10),border: Border.all(width: 1)),
                  child: DropdownButtonFormField<String>(
                    value: selectedYear,
                    hint: const Text('Select Year'),
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                        log(selectedYear.toString());
                      });
                    },
                  ),
                ),
                 DateOfBirthField(
            controller: dob,
            label: 'Date of Birth',
            hintText: 'Select your date of birth',
          ),
                MyTextField(
                    controller: number,
                    keyboardType: TextInputType.number,
                    label: 'Mobile Number',
                    hintText: "7905539159"),
               
                const SizedBox(height: 10),
               AppButton(hint: "Add", onPressed: (){ if (validate()) {
                          addUser();
                          Get.back();
                        }})
              ] 
            )
          ),
        ),
      ));
  }

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
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
      "Roll_No.": int.parse(rollNo.text.trim()),
      "Branch":selectedBranch,
      "Year":selectedYear,
      "DOB": dob.text,
      "Mobile_No": int.parse(number.text.trim()),
      "userId": auth.currentUser!.uid,
    };
    log("befor adding user:");
    Map? res = await FireStoreService.addUser(users);
    if (res == null) {
      log("after addig error addd ni hua");
    }
    log("after adding:$addUser");
    successMessage("Successfully Updated,");
    setState(() {
      name.clear();
      rollNo.clear();
      number.clear();
      dob.clear();
    });
    log('data: $users');
  }


  void pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
      StorageService.uploadFile("profilePic", "fileName.jpg", file: pickedImage)
          .then((value) {
        FireStoreService.updateUser({"image": value});

        print("file uploaded \n $value");
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
    successMessage("Update Image");
  }

 
  
  bool validate() {
    if (name.text.isEmpty) {
      showToastMessage('Please enter Name.');
      return false;
    }
    if (rollNo.text.isEmpty) {
      showToastMessage('Please enter Roll_No.');
      return false;
    }
    if (selectedBranch == null) {
      showToastMessage('Please select a Branch.');
      return false;
    }
    if (selectedYear == null) {
      showToastMessage('Please select a Year.');
      return false;
    }
    if (number.text.isEmpty) {
      showToastMessage('Please enter Mobile Number.');
      return false;
    }
    if (dob.text.isEmpty) {
      showToastMessage('Please enter Parents Number.');
      return false;
    }
    return true;
  }
}
