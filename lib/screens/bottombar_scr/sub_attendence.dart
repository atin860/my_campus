import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class AttendanceSearchScreen extends StatefulWidget {
  const AttendanceSearchScreen({super.key});

  @override
  State<AttendanceSearchScreen> createState() => _AttendanceSearchScreenState();
}

class _AttendanceSearchScreenState extends State<AttendanceSearchScreen> {
  String searchQuery = "";

  final List<Map<String, dynamic>> attendanceData = [
    {
      'subject': 'Mathematics',
      'attendance': 85,
      'daysPresent': 42,
      'totalDays': 50
    },
    {
      'subject': 'Oprating system',
      'attendance': 75,
      'daysPresent': 30,
      'totalDays': 40
    },
    {
      'subject': 'TAFAL',
      'attendance': 92,
      'daysPresent': 46,
      'totalDays': 50
    },
    {
      'subject': 'java',
      'attendance': 80,
      'daysPresent': 33,
      'totalDays': 40
    },
     {
      'subject': 'Cyber Sequrity',
      'attendance': 65,
      'daysPresent': 26,
      'totalDays': 40
    },
     {
      'subject': 'TC',
      'attendance': 75,
      'daysPresent': 30,
      'totalDays': 40
    }, {
      'subject': 'OS LAB',
      'attendance': 77,
      'daysPresent': 28,
      'totalDays': 40
    }, {
      'subject': 'CYBER LAB',
      'attendance': 99,
      'daysPresent': 39,
      'totalDays': 40
    },
    {
      'subject': 'JAVA LAB',
      'attendance': 0,
      'daysPresent': 0,
      'totalDays': 40
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Attendance Tracker',style: kLabelTextStyle,),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildAttendanceList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value.toLowerCase();
          });
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "Search subjects...",
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceList() {
    List<Map<String, dynamic>> filteredData = attendanceData
        .where((subjectData) =>
            subjectData['subject'].toLowerCase().contains(searchQuery))
        .toList();

    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        return _buildAttendanceCard(filteredData[index]);
      },
    );
  }

  Widget _buildAttendanceCard(Map<String, dynamic> subjectData) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subjectData['subject'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${subjectData['daysPresent']} of ${subjectData['totalDays']} days present',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            _buildAttendancePercentage(subjectData['attendance']),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendancePercentage(int attendance) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(
            value: attendance / 100,
            strokeWidth: 6,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              attendance >= 75 ? Colors.green : Colors.red,
            ),
          ),
        ),
        Text(
          '$attendance%',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
