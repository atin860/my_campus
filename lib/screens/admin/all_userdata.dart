import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';

class StudentData extends StatefulWidget {
  const StudentData({super.key});

  @override
  State<StudentData> createState() => _StudentDataState();
}

class _StudentDataState extends State<StudentData> {
  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('users'); // Replace with your collection name
  String selectedYear = 'All'; // Default filter for Year
  String selectedBranch = 'All'; // Default filter for Branch
  Map user = {};
  String? imageUrl;
  bool isLoading = true; // For showing a loader during data fetch

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    try {
      String userId = auth.currentUser!.uid; // Current user's UID
      DocumentSnapshot userDoc = await FireStoreService.getUserData(userId);

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          user = userData; // Populate user data
          imageUrl = userData['image']; // Assign profile image URL
          isLoading = false; // Data fetch complete
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "User Data List"),
      body: Column(
        children: [
          // Filter Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Dropdown for Year
                DropdownButton<String>(
                  value: selectedYear,
                  items: ['All', '1st Year', '2nd Year', '3rd Year', '4th Year']
                      .map((year) => DropdownMenuItem(
                            value: year,
                            child: Text(year),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value!;
                    });
                  },
                ),
                // Dropdown for Branch
                DropdownButton<String>(
                  value: selectedBranch,
                  items: [
                    'All',
                    'AI',
                    'AIML',
                  ]
                      .map((branch) => DropdownMenuItem(
                            value: branch,
                            child: Text(branch),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBranch = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          // List of Users
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: usersCollection.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching data'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No users found'));
                }

                // Filter users based on selected year and branch
                final filteredUsers = snapshot.data!.docs.where((doc) {
                  final user = doc.data() as Map<String, dynamic>;
                  final yearMatches = selectedYear == 'All' ||
                      user['Year'] == selectedYear; // Year filter
                  final branchMatches = selectedBranch == 'All' ||
                      user['Branch'] == selectedBranch; // Branch filter
                  return yearMatches && branchMatches;
                }).toList();

                if (filteredUsers.isEmpty) {
                  return const Center(child: Text('No users match the filter'));
                }

                return ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user =
                        filteredUsers[index].data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () => _showUserDetails(user),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(user['Name']?[0] ?? '?'),
                          ),
                          title: Text(user['Name'] ?? 'Unknown Name'),
                          subtitle: Text(
                            user['Roll_No']?.toString() ?? 'Unknown Roll No.',
                            style: const TextStyle(fontSize: 13),
                          ),
                          trailing: Text(
                            '${user['Year']} - ${user['Branch']}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showUserDetails(Map<String, dynamic> user) {
    showModalBottomSheet(
      backgroundColor: kappbarback,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Name and Profile Image
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      user['Name'] ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (imageUrl != null &&
                                Uri.tryParse(imageUrl!) != null)
                            ? NetworkImage(imageUrl!)
                            : const AssetImage('assets/logo/logo.gif')
                                as ImageProvider,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Dynamic Details
              _buildDetailRow('Roll No', user['Roll_No']),
              _buildDetailRow('Year', user['Year']),
              _buildDetailRow('Branch', user['Branch']),
              _buildDetailRow('Mobile No', user['Mobile_No']),
              _buildDetailRow('DOB', user['DOB']),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// Reusable widget for displaying details
  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label :',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value != null ? value.toString() : 'N/A',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
