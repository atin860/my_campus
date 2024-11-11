import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignmentListScreen extends StatefulWidget {
  @override
  _AssignmentListScreenState createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(title: "'Uploaded Assignments'"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('assignments').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
        
            if (snapshot.hasError) {
              return Center(child: Text('Error loading assignments.'));
            }
        
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No assignments uploaded.'));
            }
        
            // Get the list of documents (assignments)
            final assignments = snapshot.data!.docs;
        
            return ListView.builder(
              itemCount: assignments.length,
              itemBuilder: (context, index) {
                // Get assignment data
                var assignment = assignments[index];
                var fileName = assignment['file_name'];
                var fileUrl = assignment['url'];
                var uploadDate = assignment['uploaded_at'];
        
                return Card(color: const Color.fromARGB(255, 167, 219, 214),
                  child: ListTile(
                    leading: Icon(Icons.file_present),
                    title: Text(fileName,style: TextStyle(fontSize: 15),),
                    subtitle: Text('Uploaded on: $uploadDate'),
                    trailing: IconButton(
                      icon: Icon(Icons.download),
                      onPressed: () {
                        // Open the file URL (download or view)
                        _openFile(fileUrl);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Function to open/download the file (e.g., using url_launcher)
  void _openFile(String url) async {
    // You can use url_launcher to open the file in a browser
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
