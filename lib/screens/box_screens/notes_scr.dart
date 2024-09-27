// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:my_campus/service/firebase_database.dart';
//  // Your Firestore service for uploading and managing PDFs

// class NotesScreen extends StatefulWidget {
//   @override
//   _NotesScreenState createState() => _NotesScreenState();
// }

// class _NotesScreenState extends State<NotesScreen> {
//   TextEditingController _titleController = TextEditingController();
//   File? _selectedFile;
//   bool _isLoading = false;

//   // Method to select a PDF file
//   Future<void> _pickPdf() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//     if (result != null) {
//       setState(() {
//         _selectedFile = File(result.files.single.path!);
//       });
//     } else {
//       _showToastMessage("No file selected");
//     }
//   }

//   // Method to upload PDF and add note
//   Future<void> _uploadNote() async {
//     if (_selectedFile == null || _titleController.text.isEmpty) {
//       _showToastMessage("Please select a PDF and enter a title.");
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     // Upload PDF to Firebase Storage
//     String? pdfUrl = await FireStoreService.uploadPdfToStorage(_selectedFile!);

//     if (pdfUrl != null) {
//       // Add note to Firestore with the PDF URL
//       await FireStoreService.addNoteWithPdf(_titleController.text, pdfUrl);
//     }

//     setState(() {
//       _isLoading = false;
//     });

//     Navigator.pop(context); // Go back after adding the note
//   }

//   // Method to display toast messages
//   void _showToastMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Manage Notes"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title Input Field
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(
//                 labelText: "Enter Note Title",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // PDF Upload Button
//             ElevatedButton.icon(
//               onPressed: _pickPdf,
//               icon: Icon(Icons.upload_file),
//               label: Text('Select PDF'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blueAccent,
//               ),
//             ),

//             // Show Selected File Name
//             _selectedFile != null
//                 ? Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Text(
//                       'Selected File: ${_selectedFile!.path.split('/').last}',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   )
//                 : Container(),

//             // Upload Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _uploadNote,
//                 child: _isLoading ? CircularProgressIndicator() : Text('Upload Note'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Existing Notes List
//             Expanded(child: _buildNotesList()),
//           ],
//         ),
//       ),
//     );
//   }

//   // Build the Notes List from Firestore
//   Widget _buildNotesList() {
//     return StreamBuilder(
//       stream: FireStoreService.notes.snapshots(), // Stream the notes from Firestore
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) {
//           return Center(child: CircularProgressIndicator());
//         }

//         var notes = snapshot.data!.docs;
//         return ListView.builder(
//           itemCount: notes.length,
//           itemBuilder: (context, index) {
//             var note = notes[index];
//             return GestureDetector(
//               onTap: () => _showNoteDetails(note['title'], note['pdfUrl']),
//               child: Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 child: ListTile(
//                   leading: Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 40),
//                   title: Text(note['title']),
//                   subtitle: Text('Tap to view'),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // Method to show Note details in Bottom Sheet
//   void _showNoteDetails(String title, String pdfUrl) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               TextButton.icon(
//                 onPressed: () {
//                   _openPdf(pdfUrl); // Open PDF in browser or PDF viewer
//                 },
//                 icon: Icon(Icons.open_in_new, color: Colors.blue),
//                 label: Text('Open PDF'),
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Method to open the PDF (could be in browser or an external PDF viewer)
//   void _openPdf(String pdfUrl) {
//     // Implement opening PDF (either via external viewer or WebView)
//     print("Opening PDF: $pdfUrl");
//   }
// }
