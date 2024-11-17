import 'dart:developer';

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/screens/profile%20ui/help_support.dart';
import 'package:my_campus/screens/profile%20ui/notification.dart';
import 'package:my_campus/screens/profile%20ui/privacy_seq.dart';

import 'package:my_campus/screens/helper/helper.dart';

import 'package:my_campus/screens/profile%20ui/user_data.dart';

import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // You can define any state variables here if needed.
  String userName = "Atin Sharma";
  String userEmail = "atin.vSafe.com";
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
    String userId = auth.currentUser!.uid;
    String url = await links.getProfileImageUrl(userId);
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: kappbarback),
          ),
          // Profile Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              _buildProfileHeader(),
              const SizedBox(height: 20),
              Expanded(
                child: _buildProfileDetails(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Profile Header with Avatar, Name, and Email
  Widget _buildProfileHeader() {
    return Column(
      children: [
        ClipOval(
          child: imageUrl != null
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
        const SizedBox(height: 10),
        Text(
          user['Name'] ?? "",
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          userEmail,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  // Profile Details with Cards for Info, Settings, and Actions
  Widget _buildProfileDetails() {
    return FadeInUp(
      duration: Duration(seconds: 1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: ListView(
          children: [
            _buildProfileCard(
              icon: Icons.person,
              title: "Personal Info",
              subtitle: "View and update your personal details",
              onTap: () {
                Get.to(() => UserData());
              },
            ),
            _buildProfileCard(
              icon: Icons.lock,
              title: "Privacy Settings",
              subtitle: "Manage your account privacy",
              onTap: () {
                // Navigate to Privacy Settings
                Get.to(() => PrivacySettingsScreen());
              },
            ),
            _buildProfileCard(
              icon: Icons.notifications,
              title: "Notifications",
              subtitle: "Manage your notification preferences",
              onTap: () {
                // Navigate to Notifications
                Get.to(() => NotificationsScreen());
              },
            ),
            _buildProfileCard(
              icon: Icons.help,
              title: "Help & Support",
              subtitle: "Get help and find answers",
              onTap: () {
                // Navigate to Help & Support
                Get.to(() => HelpSupportScreen());
              },
            ),
            const SizedBox(height: 30),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  // Profile Card for Each Setting/Action
  Widget _buildProfileCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  // Logout Button
  Widget _buildLogoutButton() {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout, color: Colors.white),
        label: const Text(
          "Logout",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          // Handle logout functionality
        },
      ),
    );
  }
}
