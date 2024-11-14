import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_campus/main.dart';
import 'package:my_campus/screens/auth_view/user_data.dart';
import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';

class PerInfo extends StatefulWidget {
  const PerInfo({super.key});

  @override
  State<PerInfo> createState() => _PerInfoState();
}

class _PerInfoState extends State<PerInfo> {
  final FireStoreService fireStoreService = FireStoreService();
Map user={};
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  void getUser() async {
    log("chalo");
    Map data = await FireStoreService.getUser();
       log("data $data");
       if (mounted) {
  setState(() {
    // Your state update logic here
    user=data;
  });
}

  }

  @override
  Widget build(BuildContext context) {
      String? email = fireStoreService.getCurrentUserEmail();
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: MyAppBar(title: "User Info",titleAlignment: TextAlign.center,)
,      body:
       Column(
         children: [
           _buildProfileHeader(context),
           const SizedBox(height: 10),
           _buildPersonalInfoList(context),
         ],
       ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(onPressed: (){ Get.to(()=>UserDataScr());}
       , backgroundColor: Colors.red,child: Icon(Icons.edit,color: Colors.white,),),
      ),
    );
  }

  // Widget for profile header (avatar and name)
  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage(
                'assets/img/profile.jpeg'), // Replace with your profile image
          ),
          const SizedBox(height: 15),
           Text(
      user['Name']??"",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 5),
          Text(
           user['Year']??"",
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
                    _buildInfoCard(Icons.insert_drive_file, "Roll_NO.", user['Roll_No.'].toString()??"",),
          _buildInfoCard(Icons.class_outlined, "Branch", user['Branch']??''),
          _buildInfoCard(Icons.calendar_month, "Year", user['Year']??"", ),
          _buildInfoCard(Icons.phone, "Phone", user['Mobile_No'].toString()??''),
          _buildInfoCard(Icons.calendar_today, "Date of Birth", user['DOB']??''),
           _buildInfoCard(Icons.email, "Email", "${fireStoreService.getCurrentUserEmail()}"),
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
        subtitle:fireStoreService.getCurrentUserEmail()!.isNotEmpty?Text(data):Center(child: CircularProgressIndicator())
      )
    );
  }
}
