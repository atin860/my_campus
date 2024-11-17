import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_campus/screens/box_screens/assignment.dart';
import 'package:my_campus/screens/box_screens/attendence.dart';
import 'package:my_campus/screens/box_screens/event.dart';
import 'package:my_campus/screens/box_screens/faculty.dart';
import 'package:my_campus/screens/box_screens/id_card.dart';
import 'package:my_campus/screens/box_screens/notes_scr.dart';
import 'package:my_campus/screens/box_screens/quiz.dart';
import 'package:my_campus/screens/box_screens/team.dart';
import 'package:my_campus/widget/appcontainer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  // Function to open a website URL
  Future<void> openWebUrl(BuildContext context) async {
    final Uri url = Uri.parse('https://www.bansaliet.in/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showSnackBar(context, 'Could not launch URL');
    }
  }

  // Function to open the result portal
  Future<void> openResultPortal(BuildContext context) async {
    final Uri url =
        Uri.parse('https://erp.aktu.ac.in/WebPages/OneView/OneView.aspx');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showSnackBar(context, 'Could not launch URL');
    }
  }

  // Function to handle share action
  void shareApp() {
    Share.share('Check out this amazing app: https://example.com');
  }

  // Function to open email app for feedback
  Future<void> sendFeedback(BuildContext context) async {
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
      _showSnackBar(context, 'Could not launch email app');
    }
  }

  // Helper function to show SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Function to build the UI with action containers
  FadeInUp allBox(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MyContainer(
              name: 'Website',
              image: 'web',
              onPressed: () {
                openWebUrl(context); // Correct context usage
              },
            ),
            MyContainer(
                name: 'Result',
                image: 'result',
                onPressed: () {
                  openResultPortal(context); // Correct context usage
                }),
            MyContainer(
              name: 'Notes',
              image: 'notes',
              onPressed: () {
                Get.to(() => NotesScreen());
              },
            ),
            MyContainer(
              name: 'Assignment',
              image: 'assignment',
              onPressed: () {
                Get.to(() => AssignmentScr());
              },
            ),
            MyContainer(
              name: 'Attendance',
              image: 'attendence',
              onPressed: () {
                Get.to(() => AttendanceScreen());
              },
            ),
            MyContainer(
              name: 'ID Card',
              image: 'IdCard',
              onPressed: () {
                Get.to(() => const IdCardScreen(
                      name: "Atin Sharma",
                      rollNumber: "2204221520010",
                      department: "CSE(AI)",
                      imagePath: "assets/img/atin.jpeg",
                    ));
              },
            ),
            MyContainer(
              name: 'Event',
              image: 'events',
              onPressed: () {
                Get.to(() => const EventScreen());
              },
            ),
            MyContainer(
              name: 'Quiz',
              image: 'quiz',
              onPressed: () {
                Get.to(() => const QuizScreen());
              },
            ),
            MyContainer(
              name: 'Faculty',
              image: 'faculty',
              onPressed: () {
                Get.to(() => const FacultyListScreen());
              },
            ),
            MyContainer(
              name: 'Team',
              image: 'team',
              onPressed: () {
                Get.to(() => const TeamMembersScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

// slider image list
  final List<String> imgList = [
    'assets/img/back2.jpg',
    'assets/img/atin.jpeg',
    // Add more images here
  ];
  // Image Slider with custom images
  CarouselSlider ImageSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        // autoPlayAnimationDuration: Duration(seconds: 1),
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
      ),
      items: imgList.map((item) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(item),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class Links {
  Future<String> getProfileImageUrl(String userId) async {
    try {
      // Get a reference to the image stored in Firebase Storage
      Reference reference =
          FirebaseStorage.instance.ref().child('profilePic/$userId.jpg');

      // Get the download URL
      String downloadUrl = await reference.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error fetching profile image: $e');
      return 'default_image_url'; // Return a default image URL if there's an error
    }
  }
}
