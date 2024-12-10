import 'dart:developer';
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
    const AdminPanel(),
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
  Map<String, dynamic>? userData; // Holds user data
  bool isLoading = true; // For showing a loading spinner
  Map<dynamic, dynamic> user = {};
  @override
  void initState() {
    super.initState();
    getUser();
  }

  // Fetch user data from firebase
  void getUser() async {
    log("Fetching user data...");
    try {
      Map data = await FireStoreService.getUser();
      log("Fetched data: $data");
      if (mounted) {
        setState(() {
          user = data;
          isLoading = false;
        });
      }
    } catch (e) {
      log("Error fetching user data: $e");
      setState(() {
        isLoading = false; // Stop the loader if there's an error
      });
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
        title: user['Name'] ?? "Hello User!",
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                //  advText,
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
