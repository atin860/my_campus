
import 'dart:io';
import 'package:path/path.dart'; // For getting file name
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/widget/toast_msg.dart';

class FireStoreService {
  static FirebaseFirestore instance = FirebaseFirestore.instance;
  // static CollectionReference tasks = instance.collection('tasks');
  static CollectionReference users = instance.collection('users');
  static CollectionReference notes = instance.collection('notes');


//Add user data in firebase
 static Future<Map?> addUser(Map<String, dynamic> data) async {
    try {
      return users.doc(auth.currentUser?.uid).set(data).then((value) => data);
    } catch (e) {
      showToastMessage("error:$e");
      print("add user error : $e");

      return null;
    }
  }

  static Future<Map?> updateUser(Map<String, dynamic> data) async {
    try {
      return users
          .doc(auth.currentUser?.uid)
          .update(data)
          .then((value) => data);
    } catch (e) {
      showToastMessage("error:$e");
      print("add user error : $e");

      return null;
    }
  }

  static Future<Map> getUser() async {
    try {
      return users
          .doc(auth.currentUser?.uid)
          .get()
          .then((value) => value.exists ? value.data() as Map : {});
    } catch (e) {
      showToastMessage("error:$e");
      print("get task error : $e");

      return {};
    }
  }


  // Method to upload PDF to Firebase Storage
  static Future<String?> uploadPdfToStorage(File pdfFile) async {
    try {
      String fileName = basename(pdfFile.path); // Get file name
      Reference storageRef = FirebaseStorage.instance.ref().child('pdfs/$fileName');
      UploadTask uploadTask = storageRef.putFile(pdfFile);

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL(); // Get download URL

      return downloadUrl; // Return the URL of the uploaded PDF
    } catch (e) {
      showToastMessage("Error uploading PDF: $e");
      return null;
    }
  }

  // Method to add note data (with PDF URL) to Firestore
  static Future<bool> addNoteWithPdf(String title, String pdfUrl) async {
    try {
      await notes.add({
        'title': title,
        'pdfUrl': pdfUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
      showToastMessage("Note added successfully");
      return true;
    } catch (e) {
      showToastMessage("Error adding note: $e");
      return false;
    }
  }
}

// // task function .....1..................................................
//   static Future<Map?> addTask(Map<String, dynamic> data) async {
//     try {
//       return tasks.add(data).then((value) => data);
//     } catch (e) {
//       showToastMessage("error:$e");
//       print("add task error : $e");

//       return null;
//     }
//   }

// // / task function ...2..................................................
//   static Future<List> getTask() async {
//     try {
//       List data = [];
//       return tasks
//           .where('userId', isEqualTo: auth.currentUser!.uid)
//           .get()
//           .then((value) => value.docs.map((e) => e.data() as Map).toList());
//       return data;
//     } catch (e) {
//       showToastMessage("error:$e");
//       print("get task error : $e");

//       return [];
//     }
//   }

// // / task function ...3..................................................
//   static deleteTask(id) {
//     try {
//       return tasks.doc(id).delete();
//     } catch (e) {
//       showToastMessage("error:$e");
//       print("add task error : $e");
//     }
//   }

// // task function .....4........................................................
//   static editTask(id, Map<String, dynamic> data) {
//     try {
//       return tasks.doc(id).update(data);
//     } catch (e) {
//       showToastMessage("error:$e");
//       print("add task error : $e");
//     }
//   }

