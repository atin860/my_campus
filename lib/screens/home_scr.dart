import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/home_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // To keep track of the currently selected tab

  // List of pages to display for each tab
  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
  ];

  // Function to handle tab changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
              Container(
                height: screenHeight * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kBackgroundColors,
                    borderRadius: BorderRadius.circular(15)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeContainer(itemName: "hello"),
                      HomeContainer(itemName: "hello"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),

      // this is bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
