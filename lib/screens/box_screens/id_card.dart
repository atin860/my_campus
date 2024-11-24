import 'package:flutter/material.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';

class IdCardScreen extends StatelessWidget {
  final String name;
  final String rollNumber;
  final String department;
  final String imagePath;

  const IdCardScreen({
    Key? key,
    required this.name,
    required this.rollNumber,
    required this.department,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "My Id Card"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.blue),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      "BIET LUCKNOW",
                      style: kLabelTextStyle,
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            imagePath,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: $name",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Roll No: $rollNumber",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Department: $department",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
