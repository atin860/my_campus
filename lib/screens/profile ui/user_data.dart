import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/screens/profile%20ui/user_datafoam.dart';
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
  Map user = {};
  String? imageUrl;
  bool isLoading = true; // For showing a loader during data fetch

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data including the image URL
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    try {
      String userId = auth.currentUser!.uid; // Current user's UID
      DocumentSnapshot userDoc = await FireStoreService.getUserData(userId);

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          user = userData; // Populate user data
          imageUrl = userData['image']; // Assign profile image URL
          isLoading = false; // Data fetch complete
        });
      } else {
        // Handle case when no user document is found
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: MyAppBar(
        title: "User Data",
        titleAlignment: TextAlign.center,
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loader while fetching data
          : Column(
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
            Get.to(() => UserDataForm());
          },
          backgroundColor: Colors.red,
          child: const Icon(
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
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors
                .grey[300], // Default background color if image not loaded
            backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                ? NetworkImage(imageUrl!) // Display fetched image URL
                : const AssetImage('assets/logo/logo.gif')
                    as ImageProvider, // Default placeholder image
          ),
          const SizedBox(height: 15),
          Text(
            user['Name'] ?? "Hello User!",
            style: const TextStyle(
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
            user['Roll_No']?.toString() ?? 'Not Available',
          ),
          _buildInfoCard(Icons.class_outlined, "Branch", user['Branch'] ?? ''),
          _buildInfoCard(
            Icons.calendar_month,
            "Year",
            user['Year'] ?? "Not Available",
          ),
          _buildInfoCard(
              Icons.phone, "Phone", user['Mobile_No']?.toString() ?? ''),
          _buildInfoCard(
              Icons.calendar_today, "Date of Birth", user['DOB'] ?? ''),
          _buildInfoCard(Icons.email, "Email",
              fireStoreService.getCurrentUserEmail() ?? ''),
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
        subtitle: Text(data),
      ),
    );
  }
}
