import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase Core
import 'package:firebase_storage/firebase_storage.dart'; // Firebase Storage
import 'package:firebase_database/firebase_database.dart'; // Firebase Realtime Database
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'package:file_picker/file_picker.dart'; // File Picker
import 'package:my_campus/widget/app_button.dart';
import 'dart:io';

import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/textfield.dart'; // For File I/O


class AssignmentScr extends StatefulWidget {
  @override
  State<AssignmentScr> createState() => _AssignmentScrState();
}

class _AssignmentScrState extends State<AssignmentScr> {
  File? selectedFile; // To store the selected file
  bool isUploading = false; // Upload progress state
  TextEditingController _fileNameController = TextEditingController(); // To store custom file name

  // Function to pick a file
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg'], // Add other formats as needed
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);

        // Set the default file name to the original file name
        String fileName = result.files.single.name;
        _fileNameController.text = fileName.split('.').first; // Set name without extension
      });
    } else {
      // User canceled the picker
    }
  }

  // Function to upload the file and save metadata
  Future<void> uploadFile() async {
    if (selectedFile == null || _fileNameController.text.isEmpty) return;

    setState(() {
      isUploading = true;
    });

    try {
      // Define the custom file name entered by the user
      String fileExtension = selectedFile!.path.split('.').last; // Get the file extension
      String fileName = '${_fileNameController.text}.$fileExtension'; // Combine name and extension

      // Upload the file to Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('assignments/$fileName');
      UploadTask uploadTask = ref.putFile(selectedFile!);
      TaskSnapshot snapshot = await uploadTask;

      // Get the file URL after upload
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save metadata to Firebase Firestore
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
      appBar: MyAppBar(title: 'Assignment'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectedFile != null) ...[
                Text('Selected File: ${selectedFile!.path.split('/').last}'),
                SizedBox(height: 10),
               MyTextField(label: "Edit file name", hintText:'',controller:  _fileNameController,),
                SizedBox(height: 20),
              ],
            AppButton(hint: "Choose file", onPressed: pickFile,),
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
