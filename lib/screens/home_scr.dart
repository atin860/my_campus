import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/screens/auth_view/user_data.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/appcontainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  MainController controller = Get.find();
  // Function to handle tab changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> imgList = [
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kBackgroundColors,
          title: const Text(
            "HELLO USER!",
            style: kLabelTextStyle,
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      controller.logout();
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ))),
          ]),
      drawer: const Drawer(
        width: 270,
        shadowColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 134, 189, 255),
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
              )
            ],
          ),
        ),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ImageSlider(),
              const SizedBox(
                height: 20,
              ),
              AllBox(),
            ],
          ),
        ),
      ]),

      // this is bottom navigation bar
      bottomNavigationBar: NavigationBar(),
    );
  }

  Column AllBox() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyContainer(name: 'Website', image: 'web', onPressed: () {}),
            MyContainer(
              name: 'Notes',
              image: 'notes',
              onPressed: () {
                Get.to(()=>UserDataScr());
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
              onPressed: () {},
            ),
            MyContainer(
              name: 'Quiz',
              image: 'quiz',
              onPressed: () {},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyContainer(
              name: 'Event',
              image: 'events',
              onPressed: () {},
            ),
            MyContainer(
              name: 'Assignment',
              image: 'assignment',
              onPressed: () {},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyContainer(
              name: 'Attendence',
              image: 'erp',
              onPressed: () {},
            ),
            MyContainer(
              name: 'Id Card',
              image: 'IdCard',
              onPressed: () {},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyContainer(
              name: 'Faculty',
              image: 'faculty',
              onPressed: () {},
            ),
            MyContainer(
              name: 'Team',
              image: 'team',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  BottomNavigationBar NavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped, // Call the function on tab change
    );
  }

  CarouselSlider ImageSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        // autoPlayAnimationDuration: Duration(microseconds: 5000),
        autoPlay: true, // Auto-play feature
        enlargeCenterPage: true, // Makes the center image larger
        aspectRatio: 16 / 9, // Aspect ratio of the images
        viewportFraction: 0.9, // Width of each item in relation to the viewport
      ),
      items: imgList
          .map((item) => Container(
                // child: Image.network(item, fit: BoxFit.cover, width: 2000),
                child: const Image(image: AssetImage("assets/img/back1.jpg")),
              ))
          .toList(),
    );
  }
}
