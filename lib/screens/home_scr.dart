import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/appcontainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

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
      ),
      drawer: const Drawer(
        backgroundColor: kBackgroundColors,
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
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             MyContainer(
              name: 'Website', image: 'web',
            ),
            MyContainer(
              name: 'Notes', image: 'notes',
            ),
          
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             MyContainer(
              name: 'Result', image: 'result',
            ),
            MyContainer(
              name: 'Quiz', image: 'quiz',
            ),
          ],
        ), Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyContainer(
              name: 'Event', image: 'events',
            ),
            MyContainer(
              name: 'Assignment', image: 'assignment',
            ),
          ],
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyContainer(
              name: 'Attendence', image: 'erp',
            ),
            MyContainer(
              name: 'Id Card', image: 'IdCard',
            ),
          ],
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyContainer(
              name: 'Faculty', image: 'faculty',
            ),
            MyContainer(
              name: 'Team', image: 'team',
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
                child: Image(image: AssetImage("assets/img/human.png")),
              ))
          .toList(),
    );
  }
}
