import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignmentScr extends StatefulWidget {
  @override
  State<AssignmentScr> createState() => _AssignmentScrState();
}

class _AssignmentScrState extends State<AssignmentScr> {
  FireStoreService fireStoreService = FireStoreService();

  // Function to open a URL
  Future<void> _downloadFile(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the file.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Assignment'),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: fireStoreService.fetchUploadedFilesToAssignmnet(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No assignments uploaded yet.'));
                }
                final files = snapshot.data!.docs;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      return Card(
                        color: Colors.blue[100],
                        child: ListTile(
                          title: Text(file['file_name']),
                          subtitle: Text(
                            'Uploaded: ${DateTime.parse(file['uploaded_at']).toLocal()}',
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.download),
                            onPressed: () {
                              _downloadFile(file['url']);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
