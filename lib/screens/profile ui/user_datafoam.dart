import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/app_button.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/textfield.dart';
import 'package:my_campus/widget/toast_msg.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore

class UserDataForm extends StatefulWidget {
  const UserDataForm({super.key});

  @override
  State<UserDataForm> createState() => _UserDataFormState();
}

class _UserDataFormState extends State<UserDataForm> {
  TextEditingController name = TextEditingController();
  TextEditingController rollNo = TextEditingController();
  TextEditingController number = TextEditingController();
  final TextEditingController dob = TextEditingController();
  String userId = FirebaseAuth.instance.currentUser!.uid;

  String? selectedBranch;
  String? selectedYear;
  String? imageUrl;
  File? pickedImage;
  final ImagePicker imgpicker = ImagePicker();
  List<String> branches = ['AI', 'AIML'];
  List<String> years = ['2nd Year', '3rd Year', '4th Year'];

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data on screen load
  }

  // Function to fetch user data from Firestore
  Future<void> fetchUserData() async {
    String userId = auth.currentUser!
        .uid; // Assuming you're using FirebaseAuth to get the current user's UID

    // Fetch the user data from Firestore
    DocumentSnapshot userDoc = await FireStoreService.getUserData(userId);

    if (userDoc.exists) {
      // Get the data and set the values in the text fields and dropdowns
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      setState(() {
        name.text = userData['Name'] ?? '';
        rollNo.text =
            userData['Roll_No'].toString(); // Assuming it's stored as a number
        number.text = userData['Mobile_No'].toString();
        dob.text = userData['DOB'] ?? '';
        selectedBranch = userData['Branch'];
        selectedYear = userData['Year'];
        imageUrl =
            userData['image']; // If the user has an uploaded profile image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: kScaffoldColor,
        appBar: const MyAppBar(title: "User Data Form"),
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
                                  )
                                : Image.asset(
                                    "assets/logo/logo.gif",
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                      ),
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 229, 224, 224),
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 229, 224, 224),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1),
                  ),
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
                  hintText: "7905539159",
                ),
                const SizedBox(height: 10),
                AppButton(
                  hint: "Add",
                  onPressed: () {
                    if (validate()) {
                      addUser();
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to handle image picking
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
                    "Pick Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
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

  // Function to pick an image from the camera or gallery
  void pickImage(ImageSource imageType) async {
    try {
      // Pick an image from the specified source (camera or gallery)
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return; // No image selected, return early

      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage; // Set the picked image in the state
      });

      // Get the current user's email and replace special characters to make it a valid file name
      String userEmail = FirebaseAuth.instance.currentUser!.email!;
      String sanitizedEmail = userEmail.replaceAll(
          RegExp(r'[^a-zA-Z0-9]'), '_'); // Replace special characters

      // Use the sanitized email as the file name
      String fileName =
          "$sanitizedEmail-profile.jpg"; // Use sanitized email as file name
      String uploadPath =
          "profilePictures/$fileName"; // Path in Firebase Storage

      // Upload the file to Firebase Storage
      UploadTask uploadTask =
          FirebaseStorage.instance.ref(uploadPath).putFile(tempImage);

      // Wait for the upload to complete and get the download URL
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // After upload, update the user's profile image URL in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "image": downloadUrl, // Store the image URL in Firestore
      });

      // Optionally, update the local state to reflect the new image
      setState(() {
        imageUrl = downloadUrl;
      });

      // Close the bottom sheet or dialog
      Get.back();

      // Show a success message
      successMessage("Profile image updated successfully!");
    } catch (error) {
      debugPrint("Error uploading image: $error");
    }
  }

  // Function to add user data to Firestore
  void addUser() async {
    FocusManager.instance.primaryFocus!.unfocus();
    Map<String, dynamic> users = {
      "Name": name.text,
      "Roll_No": int.parse(rollNo.text.trim()),
      "Branch": selectedBranch,
      "Year": selectedYear,
      "DOB": dob.text,
      "Mobile_No": int.parse(number.text.trim()),
      "userId": auth.currentUser!.uid,
    };
    log("before adding user:");
    Map? res = await FireStoreService.addUser(users);
    if (res != null) {
      successMessage("User Data Added");
    } else {
      showToastMessage("Something went wrong");
    }
  }

  // Validation for empty fields
  bool validate() {
    if (name.text.trim().isEmpty ||
        rollNo.text.trim().isEmpty ||
        selectedBranch == null ||
        selectedYear == null ||
        dob.text.trim().isEmpty ||
        number.text.trim().isEmpty) {
      showToastMessage("Please fill all the fields");
      return false;
    }
    return true;
  }
}
