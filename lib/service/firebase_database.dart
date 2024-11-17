import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_campus/widget/toast_msg.dart';

class FireStoreService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference users = firestore.collection('users');
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  // Method to get user data based on userId
  static Future<DocumentSnapshot> getUserData(String userId) async {
    try {
      // Fetching user data from Firestore using the userId
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(userId).get();
      return userDoc;
    } catch (e) {
      print('Error fetching user data: $e');
      rethrow;
    }
  }

  static Future<Map?> addUser(Map<String, dynamic> data) async {
    try {
      await users.doc(_auth.currentUser?.uid).set(data);
      return data;
    } catch (e) {
      showToastMessage("error: $e");
      print("add user error: $e");
      return null;
    }
  }

  static Future<Map?> updateUser(Map<String, dynamic> data) async {
    try {
      await users.doc(_auth.currentUser?.uid).update(data);
      return data;
    } catch (e) {
      showToastMessage("error: $e");
      print("update user error: $e");
      return null;
    }
  }

  static Future<Map> getUser() async {
    try {
      DocumentSnapshot value = await users.doc(_auth.currentUser?.uid).get();
      return value.exists ? value.data() as Map : {};
    } catch (e) {
      showToastMessage("error: $e");
      print("get user error: $e");
      return {};
    }
  }

  // Get the currently signed-in user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Get the email of the currently signed-in user
  String? getCurrentUserEmail() {
    User? user = getCurrentUser();
    return user?.email;
  }

/////// Save Data in notes Collection
  Future<String> uploadFileToNotes(File file, String fileName) async {
    try {
      Reference ref = storage.ref().child('notes/$fileName');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception("Failed to upload file: $e");
    }
  }

  Future<void> saveFileMetadataToNotes(
      String fileName, String downloadUrl) async {
    try {
      await firestore.collection('notes').add({
        'file_name': fileName,
        'url': downloadUrl,
        'uploaded_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception("Failed to save file metadata: $e");
    }
  }

  Stream<QuerySnapshot> fetchUploadedFilesToNOtes() {
    return firestore
        .collection('notes')
        .orderBy('uploaded_at', descending: true)
        .snapshots();
  }

/////// Save Data in Assignmnet Collection
  Future<String> uploadFileToAssignmnet(File file, String fileName) async {
    try {
      Reference ref = storage.ref().child('assignments/$fileName');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception("Failed to upload file: $e");
    }
  }

  Future<void> saveFileMetadataToAssignment(
      String fileName, String downloadUrl) async {
    try {
      await firestore.collection('assignments').add({
        'file_name': fileName,
        'url': downloadUrl,
        'uploaded_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception("Failed to save file metadata: $e");
    }
  }

  Stream<QuerySnapshot> fetchUploadedFilesToAssignmnet() {
    return firestore
        .collection('assignments')
        .orderBy('uploaded_at', descending: true)
        .snapshots();
  }
}
