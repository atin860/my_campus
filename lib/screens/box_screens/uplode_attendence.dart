import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_campus/widget/appbar.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Timestamp> attendanceRecords = [];
  bool _isLoading = false;
  bool _isButtonEnabled = false;
  bool testMode = true; // true to enable testing
  int totalSemesterDays = 0;

  @override
  void initState() {
    super.initState();
    _loadAttendanceRecords();
    _loadSemesterDays();
  }

  // Load total semester days from Firestore
  Future<void> _loadSemesterDays() async {
    setState(() {
      _isLoading = true;
    });
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('settings')
        .doc('semester')
        .get();

    if (docSnapshot.exists) {
      setState(() {
        totalSemesterDays = docSnapshot['totalDays'] ?? 0;
      });
    }
    setState(() {
      _isLoading = false;
    });
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
      _isButtonEnabled = isTimeValid &&
          !isAttendanceMarkedToday &&
          attendanceRecords.length < totalSemesterDays; // Disable if 100%
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

  // Calculate attendance percentage
  double _calculateAttendancePercentage() {
    if (totalSemesterDays == 0) return 0.0; // Avoid division by zero
    double percentage = (attendanceRecords.length / totalSemesterDays) * 100;
    return percentage > 100.0 ? 100.0 : percentage; // Cap at 100%
  }

  @override
  Widget build(BuildContext context) {
    double attendancePercentage = _calculateAttendancePercentage();
    return Scaffold(
      appBar: const MyAppBar(title: 'Mark Attendance'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isButtonEnabled ? _markAttendance : null,
                    child: Text(_isButtonEnabled
                        ? 'Mark Attendance'
                        : 'Attendance Button Disabled'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Attendance Percentage: ${attendancePercentage.toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Total Days: $totalSemesterDays, Present Days: ${attendanceRecords.length}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Graph Representation
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: attendancePercentage, // Cap at 100%
                            title:
                                '${attendancePercentage.toStringAsFixed(1)}%',
                            color: Colors.green,
                            radius: 50,
                            titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          PieChartSectionData(
                            value: attendancePercentage < 100
                                ? 100 - attendancePercentage
                                : 0,
                            title: '',
                            color: Colors.red,
                            radius: 50,
                          ),
                        ],
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Attendance Dates:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: attendanceRecords.length,
                      itemBuilder: (context, index) {
                        DateTime date = attendanceRecords[index].toDate();
                        return Container(
                          height: 40,
                          width: double.infinity,
                          child: Card(
                            color: Colors.green,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '${date.day}-${date.month}-${date.year}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
