import 'package:flutter/material.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';

class TeamMembersScreen extends StatelessWidget {
  const TeamMembersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: MyAppBar(title: "Meet Our Team"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: teamMembers.length,
          itemBuilder: (context, index) {
            return TeamMemberCard(
                member: teamMembers[index], context: context);
          },
        ),
      ),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final TeamMember member;
  final BuildContext context;

  const TeamMemberCard({Key? key, required this.member, required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMemberDetails(context, member),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white, // Card background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  member.imagePath,
                  height: 100,
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
                      member.title,
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
  void _showMemberDetails(BuildContext context, TeamMember member) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: kgradient,
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
                member.title,
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
                  height: 150,width: 150,
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

// Model for Team Member
class TeamMember {
  final String name;
  final String title;
  final String description;
  final String imagePath;

  TeamMember({
    required this.name,
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

// Sample Team Members Data
final List<TeamMember> teamMembers = [
  TeamMember(
    name: "Atin Sharma",
    title: "Lead Developer",
    description: "Passionate about building impactful apps.",
    imagePath: "assets/img/profile.jpeg",
  ),

  TeamMember(
    name: "Nitish Gupta",
    title: "Bakend Expert",
    description: "Ensures projects are delivered on time.",
    imagePath: "assets/team/Nitish.jpeg",
  ),
  TeamMember(
    name: "Ravi Shankar Gupta",
    title: "UI/Graphics Designer",
    description: "Loves creprofileg user-friendly designs.",
    imagePath: "assets/img/profile.jpeg",
  ),

  // Add more team members as needed
];
