
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/screens/bottombar_scr/profile%20ui/per_info.dart';
import 'package:my_campus/screens/bottombar_scr/profile%20ui/privacy_seq.dart';
import 'package:my_campus/screens/bottombar_scr/profile.dart';
import 'package:my_campus/screens/box_screens/assignment.dart';
import 'package:my_campus/screens/box_screens/attendence.dart';
import 'package:my_campus/screens/box_screens/event.dart';
import 'package:my_campus/screens/box_screens/faculty.dart';
import 'package:my_campus/screens/box_screens/id_card.dart';
import 'package:my_campus/screens/box_screens/notes_scr.dart';
import 'package:my_campus/screens/box_screens/quiz.dart';
import 'package:my_campus/screens/box_screens/team.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/appcontainer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

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
    // AttendanceSearchScreen(),
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
          // BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Attendence'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
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

  // Function to open a website URL
  Future<void> _weburl() async {
    final Uri url = Uri.parse('https://www.bansaliet.in/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  // Function to open the result portal
  Future<void> _result() async {
    final Uri url =
        Uri.parse('https://erp.aktu.ac.in/WebPages/OneView/OneView.aspx');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
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

  // Function to handle bottom navigation item tap

  final List<String> imgList = [
    // 'assets/img/back1.jpg',
    'assets/img/back2.jpg',
    'assets/img/back7.JPG',
    'assets/img/back4.JPG',
    // 'assets/img/back5.jpg',
    'assets/img/back6.JPG',
    'assets/img/back3.jpg',
    // Add more images here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: const MyAppBar(
        automaticallyImplyLeading: true,
        title: "Hello Atin!"),
      drawer: _buildCustomDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ImageSlider(),
                const SizedBox(height: 20),
                AllBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Custom Drawer with Profile Info, Share, and Feedback
  Drawer _buildCustomDrawer() {
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

  Column AllBox() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyContainer(
              name: 'Website',
              image: 'web',
              onPressed: () {
         
                _weburl();
              },
            ),
            MyContainer(
              name: 'Notes',
              image: 'notes',
              onPressed: () {
                Get.to(() => NotesScreen());
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyContainer(
              name: 'Result',
              image: 'result',
              onPressed: _result,
            ),
            MyContainer(
              name: 'Quiz',
              image: 'quiz',
              onPressed: () {
                Get.to(() => const QuizScreen());
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyContainer(
              name: 'Event',
              image: 'events',
              onPressed: () {
                Get.to(()=>const EventScreen());
              },
            ),
            MyContainer(
              name: 'Assignment',
              image: 'assignment',
              onPressed: () {  Get.to(()=>const AsignmentScr());},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyContainer(
              name: 'Attendance',
              image: 'attendence',
              onPressed: () {
                Get.to(() => const DailyAttendanceScreen());
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
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
      ],
    );
  }

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
