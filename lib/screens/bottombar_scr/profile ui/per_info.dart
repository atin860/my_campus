import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Personal Info",style: kLabelTextStyle,),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Color.fromARGB(255, 114, 178, 207)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
         
            _buildProfileHeader(context),
            const SizedBox(height: 10),
            _buildPersonalInfoList(context),
          ],
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
          const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/img/profile.jpeg'), // Replace with your profile image
          ),
          const SizedBox(height: 15),
          const Text(
            'Atin Sharma',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Software Engineer',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
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
          _buildInfoCard(Icons.email, "Email", "atin86055@gmail.com"),
          _buildInfoCard(Icons.phone, "Phone", "+91 7905539159"),
          _buildInfoCard(Icons.home, "Address", "Hardoi, India"),
          _buildInfoCard(Icons.calendar_today, "Date of Birth", "28 Oct 2003"),
          _buildInfoCard(Icons.school, "Education", "B.Tech in Computer Science"),
          _buildInfoCard(Icons.work, "Experience", "3 Years at vSafe Software Company"),
          _buildInfoCard(Icons.person, "About Me", "A passionate software developer."),
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
        subtitle: Text(
          data,
          style: const TextStyle(fontSize: 15, color: Colors.black54),
        ),
      ),
    );
  }
}
