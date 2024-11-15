import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/screens/bottombar_scr/profile%20ui/privacy_seq.dart';
import 'package:my_campus/screens/helper/helper.dart';

import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? imageUrl;
  Map user = {};

  @override
  void initState() {
    super.initState();
    fetchProfileImage();
    getUser(); // Fetch profile image when the widget is initialized
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
    String userId = auth.currentUser!.uid; // Get the current user's UID
    Links links = Links();
    String url = await links.getProfileImageUrl(userId);
    setState(() {
      imageUrl = url; // Update the imageUrl state with the fetched URL
    });
  }

  // Function to handle share action
  void _shareApp() {
    Share.share('Check out this amazing app: https://example.com');
  }

  // Function to open email app for feedback
  Future<void> _sendFeedback() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'feedback@mycampus.com',
      queryParameters: {
        'subject': 'App Feedback',
      },
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch email app')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.find();

    return Drawer(
      width: 270,
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50),
            decoration: const BoxDecoration(
                color: kappbarback,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: imageUrl != null
                      ? NetworkImage(imageUrl!) // Use the fetched image URL
                      : const AssetImage('assets/img/atin.jpeg')
                          as ImageProvider, // Default image if URL is null
                ),
                const SizedBox(height: 20),
                Text(
                  'Atin Sharma',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text('atin.vSafe.com',
                    style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    // Get.to(() => UserData());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text('Share'),
                  onTap: _shareApp,
                ),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text('Feedback'),
                  onTap: _sendFeedback,
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    // Navigate to Settings screen
                    Get.to(() => const PrivacySettingsScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    controller.logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
