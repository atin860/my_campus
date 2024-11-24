import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_campus/service/firebase_database.dart';
import 'package:my_campus/widget/app_button.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:my_campus/widget/textfield.dart';
import 'package:my_campus/widget/toast_msg.dart';

class UplodeAssignment extends StatefulWidget {
  @override
  State<UplodeAssignment> createState() => _UplodeAssignmentState();
}

class _UplodeAssignmentState extends State<UplodeAssignment> {
  File? selectedFile;
  TextEditingController _fileNameController = TextEditingController();
  bool isUploading = false;

  FireStoreService fireStoreService = FireStoreService();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        _fileNameController.text = result.files.single.name.split('.').first;
      });
    }
  }

  Future<void> uploadFile(BuildContext context) async {
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file to upload.')),
      );
      return;
    }

    setState(() {
      isUploading = true;
    });

    try {
      String fileExtension = selectedFile!.path.split('.').last;
      String fileName = _fileNameController.text.isEmpty
          ? 'Unnamed'
          : _fileNameController.text;
      fileName = '$fileName.$fileExtension';

      String downloadUrl = await fireStoreService.uploadFileToAssignmnet(
          selectedFile!, fileName);

      await fireStoreService.saveFileMetadataToAssignment(
          fileName, downloadUrl);

      successMessage("File uploaded successfully!");

      setState(() {
        selectedFile = null;
        _fileNameController.clear();
      });
    } catch (e) {
      showToastMessage("Failed to upload file.");
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Assignments'),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 213, 222, 228),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: kappbarback,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Upload Assignments",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                if (selectedFile != null) ...[
                  Text('Selected File: ${selectedFile!.path.split('/').last}'),
                  const SizedBox(height: 10),
                  MyTextField(
                    label: "Enter file name (optional)",
                    hintText: '',
                    controller: _fileNameController,
                    onTap: () => _fileNameController.clear,
                  ),
                  const SizedBox(height: 10),
                ],
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        hint: "Choose File",
                        onPressed: pickFile,
                      ),
                    ),
                    const SizedBox(width: 10),
                    isUploading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: selectedFile == null
                                ? null
                                : () {
                                    uploadFile(context);
                                  },
                            child: const Text('Upload'),
                          ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: fireStoreService.fetchUploadedFilesToAssignmnet(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text('No assignments uploaded yet.'));
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
                            icon: const Icon(Icons.download),
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
      ),
    );
  }
}
