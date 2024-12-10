import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/textfield.dart';

class AttendenceRecord extends StatefulWidget {
  @override
  _AttendenceRecordState createState() => _AttendenceRecordState();
}

class _AttendenceRecordState extends State<AttendenceRecord> {
  int totalSemesterDays = 0;
  final TextEditingController _daysController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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

  // Save semester days to Firestore
  Future<void> _saveSemesterDays() async {
    if (_daysController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });
    int days = int.parse(_daysController.text);
    await FirebaseFirestore.instance
        .collection('settings')
        .doc('semester')
        .set({
      'totalDays': days,
    });
    setState(() {
      totalSemesterDays = days;
      _isLoading = false;
    });
    _daysController.clear();
  }

  // Calculate attendance percentage
  double _calculateAttendancePercentage(int totalAttendance) {
    if (totalSemesterDays == 0) return 0.0;
    return (totalAttendance / totalSemesterDays) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Attendance Records"),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: MyTextField(
                              label: "Enter Total Semester Days",
                              keyboardType: TextInputType.number,
                              hintText: "Enter Days")),
                      SizedBox(width: 10),
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: _saveSemesterDays,
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kappbarback),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Total Semester Days: $totalSemesterDays',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('attendances')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final documents = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            var data =
                                documents[index].data() as Map<String, dynamic>;
                            var records = data['records'] as List<dynamic>;
                            int totalAttendance = records.length;
                            double percentage =
                                _calculateAttendancePercentage(totalAttendance);
                            return ListTile(
                              title: Text('User ID: ${data['userId']}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Total Attendance: $totalAttendance'),
                                  Text(
                                      'Attendance Percentage: ${percentage.toStringAsFixed(2)}%'),
                                ],
                              ),
                            );
                          },
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
