import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  FireStoreService fireStoreService = FireStoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: "NOTES"),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: fireStoreService.fetchUploadedFilesToNOtes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No notes uploaded yet.'));
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
                                final url = file['url'];
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('File URL: $url')),
                                );
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
        ));
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
