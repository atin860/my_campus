import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class DailyAttendanceScreen extends StatelessWidget {
  const DailyAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        title: const Text("Daily Attendance"),
        backgroundColor: kappbarback
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: studentAttendance.length,
          itemBuilder: (context, index) {
            return AttendanceCard(student: studentAttendance[index], context: context);
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: (){},child: Icon(Icons.play_arrow,size: 40,color: Colors.white,),),
      ),
    );
  }
}

class AttendanceCard extends StatelessWidget {
  final Student student;
  final BuildContext context;

  const AttendanceCard({Key? key, required this.student, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAttendanceDetails(context, student),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  student.imagePath,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      student.rollNumber,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      student.attendanceStatus,
                      style: TextStyle(
                        color: student.attendanceStatus == 'Present' ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show student attendance details in a bottom sheet
  void _showAttendanceDetails(BuildContext context, Student student) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent.withOpacity(0.8), Colors.lightBlueAccent.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                student.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                student.rollNumber,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Attendance Status: ${student.attendanceStatus}",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  student.imagePath,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Model for Student
class Student {
  final String name;
  final String rollNumber;
  final String attendanceStatus;
  final String imagePath;

  Student({
    required this.name,
    required this.rollNumber,
    required this.attendanceStatus,
    required this.imagePath,
  });
}

// Sample Student Attendance Data
final List<Student> studentAttendance = [
  Student(
    name: "Atin Sharma",
    rollNumber: "CS101",
    attendanceStatus: "Present",
    imagePath: "assets/img/atin.jpeg",
  ),
  Student(
    name: "John Doe",
    rollNumber: "CS102",
    attendanceStatus: "Absent",
    imagePath: "assets/img/atin.jpeg",
  ),
  Student(
    name: "Alice Smith",
    rollNumber: "CS103",
    attendanceStatus: "Present",
    imagePath: "assets/img/atin.jpeg",
  ),
  Student(
    name: "Bob Brown",
    rollNumber: "CS104",
    attendanceStatus: "Present",
    imagePath: "assets/img/atin.jpeg",
  ),
  // Add more students as needed
];
