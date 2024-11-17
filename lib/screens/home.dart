import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/screens/admin/admin.dart';
import 'package:my_campus/screens/profile%20ui/profile.dart';
import 'package:my_campus/screens/helper/helper.dart';
import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/chatbot.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/drawer.dart';

class HomeScr extends StatefulWidget {
  const HomeScr({super.key});

  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  // bottom bar
  int _selectedIndex = 0;
  static final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    AdminPanel(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings_outlined), label: 'Admin'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kappbarback,
        onTap: _onItemTapped,
      ),
    );
  }
}

//home screen class,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MainController controller = Get.find();
  final FireStoreService fireStoreService = FireStoreService();
  final Helper helper = Helper();
  Map user = {};
  String? imageUrl;
// get user data from firebase
  void getUser() async {
    log("chalo");
    Map data = await FireStoreService.getUser();
    log("data $data");
    if (mounted) {
      setState(() {
        // Your state update logic here
        user = data;
      });
    }
  }

  Future<void> _loadImage() async {
    try {
      // Reference to the file in Firebase Storage
      final storageRef =
          FirebaseStorage.instance.ref().child('profilePic/fileName.jpg');

      // Get the download URL
      final url = await storageRef.getDownloadURL();

      setState(() {
        imageUrl = url;
      });
    } catch (e) {
      print("Error fetching image URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          automaticallyImplyLeading: true,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                  onPressed: () {
                    Get.to(() => ChatBot());
                  },
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                  ),
                )),
          ],
          title: "Hello Atin!"),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                advText,
                SizedBox(
                  height: 10,
                ),
                helper.ImageSlider(),
                const SizedBox(height: 20),
                helper.allBox(context)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
