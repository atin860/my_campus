import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase Core
import 'package:firebase_storage/firebase_storage.dart'; // Firebase Storage
import 'package:firebase_database/firebase_database.dart'; // Firebase Realtime Database
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'package:file_picker/file_picker.dart'; // File Picker
import 'dart:io';

import 'package:my_campus/widget/appbar.dart'; // For File I/O


class AssignmentScr extends StatefulWidget {
  @override
  State<AssignmentScr> createState() => _AssignmentScrState();
}

class _AssignmentScrState extends State<AssignmentScr> {
  File? selectedFile; // To store the selected file
  bool isUploading = false; // Upload progress state

  // Function to pick a file
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg'], // Add other formats as needed
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  // Function to upload the file and save metadata
  Future<void> uploadFile() async {
    if (selectedFile == null) return;

    setState(() {
      isUploading = true;
    });

    try {
      // Define the file path and upload to Firebase Storage
      String fileName = selectedFile!.path.split('/').last;
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('assignments/$fileName');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = ref.putFile(selectedFile!);
      TaskSnapshot snapshot = await uploadTask;

      // Get the file URL after upload
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save metadata to Firebase Realtime Database or Firestore
      // Uncomment one based on which database you're using

      // **Option 1: Save to Firebase Realtime Database**
      /*
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref('assignments');
      await databaseRef.push().set({
        'file_name': fileName,
        'url': downloadUrl,
        'uploaded_at': DateTime.now().toIso8601String(),
      });
      */

      // **Option 2: Save to Firestore**
      CollectionReference assignments = FirebaseFirestore.instance.collection('assignments');
      await assignments.add({
        'file_name': fileName,
        'url': downloadUrl,
        'uploaded_at': DateTime.now().toIso8601String(),
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Assignment uploaded successfully!')),
      );
    } catch (e) {
      print('Error uploading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload file.')),
      );
    }

    setState(() {
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 
      'Assignment'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectedFile != null)
                Text('Selected File: ${selectedFile!.path.split('/').last}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickFile,
                child: Text('Choose File'),
              ),
              SizedBox(height: 20),
              isUploading
                  ? CircularProgressIndicator() // Show progress indicator during upload
                  : ElevatedButton(
                      onPressed: selectedFile == null ? null : uploadFile,
                      child: Text('Upload Assignment'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
