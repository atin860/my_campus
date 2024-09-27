
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/widget/toast_msg.dart';

class FireStoreService {
  static FirebaseFirestore instance = FirebaseFirestore.instance;
  // static CollectionReference tasks = instance.collection('tasks');
  static CollectionReference users = instance.collection('users');

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
}
