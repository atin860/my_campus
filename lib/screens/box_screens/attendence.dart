import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/toast_msg.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Timestamp> attendanceRecords = [];
  bool _isLoading = false;
  bool _isButtonEnabled = false;
  bool testMode = true; //  true to enable testing

  @override
  void initState() {
    super.initState();
    _loadAttendanceRecords();
  }

  // Load attendance records from Firestore
  Future<void> _loadAttendanceRecords() async {
    setState(() {
      _isLoading = true;
    });
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('attendances')
          .doc(userId)
          .get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        List<dynamic> records = docSnapshot['records'] ?? [];
        setState(() {
          attendanceRecords = List<Timestamp>.from(records);
        });
      }
    }
    _checkTimeAndLimit();
    setState(() {
      _isLoading = false;
    });
  }

  // Check if attendance can be marked based on time and daily limit
  void _checkTimeAndLimit() {
    DateTime now = DateTime.now();
    bool isTimeValid = now.hour == 9 || (now.hour == 10 && now.minute == 0);

    // If in test mode, skip time validation
    isTimeValid = testMode ? true : isTimeValid;

    bool isAttendanceMarkedToday = attendanceRecords.any((timestamp) {
      DateTime date = timestamp.toDate();
      return date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;
    });

    setState(() {
      _isButtonEnabled = isTimeValid && !isAttendanceMarkedToday;
    });
  }

  // Mark attendance and save it to Firestore
  Future<void> _markAttendance() async {
    setState(() {
      _isLoading = true;
    });
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('attendances').doc(userId);

      await userDoc.set({
        'userId': userId,
        'records': FieldValue.arrayUnion([Timestamp.now()]),
      }, SetOptions(merge: true));

      _loadAttendanceRecords();
      _checkTimeAndLimit();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Attendance System'),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isButtonEnabled ? _markAttendance : null,
                    child: Text(_isButtonEnabled
                        ? 'Mark Attendance'
                        : 'Attendance Button Disabled'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: attendanceRecords.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          width: double.infinity,
                          child: Card(
                            color: Colors.green,
                            child: Text(
                              attendanceRecords[index].toDate().toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.to(() => AdminScreen());
      }),
    );
  }
}

// Admin screen to display all users' attendance
class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Attendance Records'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('attendances').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var data = documents[index].data() as Map<String, dynamic>;
              var records = data['records'] as List<dynamic>;
              return ListTile(
                title: Text('User ID: ${data['userId']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: records.map((timestamp) {
                    return Text((timestamp as Timestamp).toDate().toString());
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
