import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_campus/screens/bottombar_scr/help_support.dart';
import 'package:my_campus/screens/bottombar_scr/profile%20ui/notification.dart';
import 'package:my_campus/screens/bottombar_scr/profile%20ui/per_info.dart';
import 'package:my_campus/screens/bottombar_scr/profile%20ui/privacy_seq.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [Color(0xff1a73e8), Color(0xff4285f4)],
              // ),
              color: kappbarback
            ),
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
        const CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage('assets/img/atin.jpeg'), // Add your image
        ),
        const SizedBox(height: 10),
        Text(
          userName,
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
    return Container(
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
              Get.to(() => PerInfo());
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
