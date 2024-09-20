import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_campus/screens/auth_view/register_scr.dart';
import 'package:my_campus/screens/auth_view/user_data.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/home_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; 

  // List of pages to display for each tab
  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    RegisterScr(),
    UserDataScr()
  ];

  // Function to handle tab changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> imgList = [
    'https://www.bansaliet.in/wp-content/uploads/2022/06/XPM_0160-1024x680-1.jpg',
    'https://images.collegedunia.com/public/college_data/images/campusimage/1687243083DSC_5493.JPG',
    // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOT-67Flatl79ijmWcCpRNLMix02cGTZbLBGuZPZM9ymG4vJa3jo6br8nUQeOhzFfOPh8&usqp=CAU',
    'https://scontent-hyd1-1.cdninstagram.com/v/t51.29350-15/457713931_506817425275560_4016082105252302484_n.heic?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xMzA0eDEzMDQuc2RyLmYyOTM1MC5kZWZhdWx0X2ltYWdlIn0&_nc_ht=scontent-hyd1-1.cdninstagram.com&_nc_cat=100&_nc_ohc=A1ik952_UzsQ7kNvgF-LRR7&_nc_gid=e493ee3946a643419ddd7c64d5910645&edm=AP4sbd4BAAAA&ccb=7-5&ig_cache_key=MzQ0NzUwOTEwOTU0NDAyNjk2Ng%3D%3D.3-ccb7-5&oh=00_AYD_vyK44jJbc2_9GjRysPmjCNvvr13IrInQmwHhzi11bw&oe=66F37C10&_nc_sid=7a9f4b',
    'https://scontent-hyd1-2.cdninstagram.com/v/t51.29350-15/414460203_872042557892886_4068138118219581069_n.heic?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi44OTh4ODk4LnNkci5mMjkzNTAuZGVmYXVsdF9pbWFnZSJ9&_nc_ht=scontent-hyd1-2.cdninstagram.com&_nc_cat=106&_nc_ohc=OgbndGrDUlAQ7kNvgHoWbP3&edm=APoiHPcBAAAA&ccb=7-5&ig_cache_key=MzI3MDc1ODg1NjMwODY1MzUxNQ%3D%3D.3-ccb7-5&oh=00_AYCSoNhiY2uBZEaUx76bL2jIgC9xs-lQ9Kz0a_uXQGnp4w&oe=66F37EE3&_nc_sid=22de04',
    'https://scontent-hyd1-2.cdninstagram.com/v/t51.29350-15/449454764_973703291119525_3448984421000827493_n.jpg?stp=dst-jpg_e35_s720x720&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xNDQweDgxMi5zZHIuZjI5MzUwLmRlZmF1bHRfaW1hZ2UifQ&_nc_ht=scontent-hyd1-2.cdninstagram.com&_nc_cat=101&_nc_ohc=Tw7CqBpU4pkQ7kNvgGMYRtF&_nc_gid=e493ee3946a643419ddd7c64d5910645&edm=AP4sbd4BAAAA&ccb=7-5&ig_cache_key=MzQwMTE0NTQ3ODM5NzA5MTM0MQ%3D%3D.3-ccb7-5&oh=00_AYDJL7iqK_GVlSNB35C6KoTk-5qJVzsd9yDhgWwbNpDKOg&oe=66F36AA6&_nc_sid=7a9f4b',
    'https://scontent-hyd1-1.cdninstagram.com/v/t51.29350-15/449463896_778632527819100_2296205695591605905_n.jpg?stp=dst-jpg_e35_s720x720&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xNDQweDgwOC5zZHIuZjI5MzUwLmRlZmF1bHRfaW1hZ2UifQ&_nc_ht=scontent-hyd1-1.cdninstagram.com&_nc_cat=100&_nc_ohc=X0g6YfX9h2IQ7kNvgGh2Cby&_nc_gid=e493ee3946a643419ddd7c64d5910645&edm=AP4sbd4BAAAA&ccb=7-5&ig_cache_key=MzQwMTE0NTQ3ODM5NzE3MjgxMQ%3D%3D.3-ccb7-5&oh=00_AYALa_kEdq7rYlLIQxTeHT1gUFGrX4C86lNyqNmbK73Zqg&oe=66F3538C&_nc_sid=7a9f4b',
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
          children: [AppContainer(), AppContainer()],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [AppContainer(), AppContainer()],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [AppContainer(), AppContainer()],
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
                child: Image.network(item, fit: BoxFit.cover, width: 2000),
              ))
          .toList(),
    );
  }
}
