import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/screens/bottombar_scr/profile%20ui/per_info.dart';
import 'package:my_campus/screens/bottombar_scr/profile%20ui/privacy_seq.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    MainController controller = Get.find();
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
    
    return Drawer(
      width: 270,
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50),
            decoration: const BoxDecoration(color: kappbarback,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
            child: const Column(children: [CircleAvatar(
              
            radius: 70,
            backgroundImage:
                AssetImage('assets/img/atin.jpeg'), // Example profile image
          ),
          SizedBox(height: 20),
          Text('Atin Sharma',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('atin.vSafe.com',
              style: TextStyle(color: Colors.black54)),],),),
          const SizedBox(height: 20),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(children: [ ListTile(
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
                 Get.to(()=> const PerInfo());
                   
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
                  Get.to(()=> const PrivacySettingsScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                controller.logout();
              },
            ),],),
         )
        ],
      ),
    );
 
  }
}