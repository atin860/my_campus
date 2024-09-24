import 'package:flutter/material.dart';

class FacultyListScreen extends StatelessWidget {
  const FacultyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meet Our Faculty"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: facultyMembers.length,
            itemBuilder: (context, index) {
              return FacultyMemberCard(member: facultyMembers[index], context: context);
            },
          ),
        ),
      ),
    );
  }
}

class FacultyMemberCard extends StatelessWidget {
  final FacultyMember member;
  final BuildContext context;

  const FacultyMemberCard({Key? key, required this.member, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMemberDetails(context, member),
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
                  member.imagePath,
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
                      member.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      member.department,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
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

  // Function to show member details in a bottom sheet
  void _showMemberDetails(BuildContext context, FacultyMember member) {
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
                member.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                member.department,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                member.description,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  member.imagePath,
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

// Model for Faculty Member
class FacultyMember {
  final String name;
  final String department;
  final String description;
  final String imagePath;

  FacultyMember({
    required this.name,
    required this.department,
    required this.description,
    required this.imagePath,
  });
}

// Sample Faculty Members Data
final List<FacultyMember> facultyMembers = [
  FacultyMember(
    name: "Dr. Atin Sharma",
    department: "Computer Science",
    description: "Expert in Software Development and AI.",
    imagePath: "assets/img/atin.jpeg",
  ),
  FacultyMember(
    name: "Prof. John Doe",
    department: "Mathematics",
    description: "Specializes in Algebra and Geometry.",
    imagePath: "assets/img/atin.jpeg",
  ),
  FacultyMember(
    name: "Dr. Alice Smith",
    department: "Physics",
    description: "Researcher in Quantum Mechanics.",
    imagePath: "assets/img/atin.jpeg",
  ),
  FacultyMember(
    name: "Mr. Bob Brown",
    department: "Chemistry",
    description: "Passionate about Organic Chemistry.",
    imagePath: "assets/img/atin.jpeg",
  ),
  // Add more faculty members as needed
];
