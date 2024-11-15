import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_campus/widget/toast_msg.dart';

class FireStoreService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final CollectionReference users = _instance.collection('users');
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to get user data based on userId
  static Future<DocumentSnapshot> getUserData(String userId) async {
    try {
      // Fetching user data from Firestore using the userId
      DocumentSnapshot userDoc =
          await _instance.collection('users').doc(userId).get();
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
    return user?.email; // Returns null if no user is signed in
  }
}
