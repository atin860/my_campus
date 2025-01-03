import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_campus/screens/admin/attendence_record.dart';
import 'package:my_campus/screens/admin/uplode_assignment.dart';
import 'package:my_campus/screens/admin/uplode_notes.dart';
import 'package:my_campus/screens/admin/all_userdata.dart';
import 'package:my_campus/screens/admin/xl_data.dart';
import 'package:my_campus/screens/box_screens/event.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/appcontainer.dart';
import 'package:my_campus/widget/constant.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Hello Sir !"),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kappbarback,
                        width: 5,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(120),
                      image: const DecorationImage(
                          image: AssetImage(
                        "assets/logo/logo.gif",
                      ))),
                )),
                const SizedBox(
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
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MyContainer(
                          name: 'Attendance',
                          image: 'attendence',
                          onPressed: () {
                            Get.to(() => AttendenceRecord());
                          },
                        ),
                        MyContainer(
                          name: 'Avinya',
                          image: 'events',
                          onPressed: () {
                            Get.to(() => const EventScreen());
                          },
                        ),
                        MyContainer(
                          name: 'Assignment',
                          image: 'assignment',
                          onPressed: () {
                            Get.to(() => UplodeAssignment());
                          },
                        ),
                        MyContainer(
                          name: 'Notes',
                          image: 'notes',
                          onPressed: () {
                            Get.to(() => UploadNotes());
                          },
                        ),
                        MyContainer(
                          name: 'User info',
                          image: 'attendence',
                          onPressed: () {
                            Get.to(() => const StudentData());
                          },
                        ),
                        MyContainer(
                          name: 'uplode info',
                          image: 'attendence',
                          onPressed: () {
                            Get.to(() => UploadAndDisplayPage());
                          },
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
