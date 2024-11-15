import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/appcontainer.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Hello Admin !"),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                    "assets/logo/logo.gif",
                  ),
                )),
                SizedBox(
                  height: 50,
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        MyContainer(
                          name: 'Attendance',
                          image: 'attendence',
                          onPressed: () {},
                        ),
                        MyContainer(
                          name: 'Avinya',
                          image: 'events',
                          onPressed: () {},
                        ),
                        MyContainer(
                          name: 'Assignment',
                          image: 'assignment',
                          onPressed: () {},
                        ),
                        MyContainer(
                          name: 'Notes',
                          image: 'notes',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
