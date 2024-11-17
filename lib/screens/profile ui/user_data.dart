import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_campus/Controller/controller.dart';

import 'package:my_campus/screens/profile%20ui/user_datafoam.dart';
import 'package:my_campus/screens/helper/helper.dart';

import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final FireStoreService fireStoreService = FireStoreService();
  final Links links = Links();
  Map user = {};
  String? imageUrl;
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    fetchProfileImage();
  }

  void getUser() async {
    log("chalo");
    Map data = await FireStoreService.getUser();
    log("data $data");
    if (mounted) {
      setState(() {
        // Your state update logic here
        user = data;
        print(user);
      });
    }
  }

  // Function to fetch profile image from Firebase Storage
  Future<void> fetchProfileImage() async {
    String userId = auth.currentUser!
        .uid; // Assuming you're using FirebaseAuth to get the current user's UID
    String url = await links.getProfileImageUrl(userId);
    setState(() {
      imageUrl = url; // Update the imageUrl state with the fetched URL
    });
  }

  @override
  Widget build(BuildContext context) {
    fireStoreService.getCurrentUserEmail();
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: MyAppBar(
        title: "User Data",
        titleAlignment: TextAlign.center,
      ),
      body: Column(
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 10),
          _buildPersonalInfoList(context),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => UserDataScr());
          },
          backgroundColor: Colors.red,
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Widget for profile header (avatar and name)
  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ClipOval(
            child: imageUrl != null
                ? CircleAvatar(
                    radius: 70,
                    child: // Display the profile image
                        imageUrl != null
                            ? Image.network(imageUrl!,
                                width: 150, height: 150, fit: BoxFit.cover)
                            : Image(image: AssetImage("assets/logo/logo.gif"))
                    // ,
                    )
                : CircularProgressIndicator(),
          ),
          const SizedBox(height: 15),
          Text(
            user['Name'] ?? "hello user !",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            user['Year'] ?? "",
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for listing personal info with icons
  Widget _buildPersonalInfoList(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildInfoCard(
            Icons.insert_drive_file,
            "Roll_NO.",
            user['Roll_No.'].toString(),
          ),
          _buildInfoCard(Icons.class_outlined, "Branch", user['Branch'] ?? ''),
          _buildInfoCard(
            Icons.calendar_month,
            "Year",
            user['Year'] ?? "",
          ),
          _buildInfoCard(
              Icons.phone, "Phone", user['Mobile_No'].toString() ?? ''),
          _buildInfoCard(
              Icons.calendar_today, "Date of Birth", user['DOB'] ?? ''),
          _buildInfoCard(Icons.email, "Email",
              "${fireStoreService.getCurrentUserEmail()}"),
          // _buildInfoCard(
          //     Icons.school, "Education", "B.Tech in Computer Science"),
        ],
      ),
    );
  }

  // Helper widget to build each info card with an icon and data
  Widget _buildInfoCard(IconData icon, String title, String data) {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
            leading: Icon(icon, size: 30, color: Colors.blueAccent),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: fireStoreService.getCurrentUserEmail()!.isNotEmpty
                ? Text(data)
                : Center(child: CircularProgressIndicator())));
  }
}
