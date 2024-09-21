
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_campus/Controller/controller.dart';
import 'package:my_campus/widget/toast_msg.dart';

class FireStoreService {
  static FirebaseFirestore instance = FirebaseFirestore.instance;
  static CollectionReference tasks = instance.collection('tasks');
  static CollectionReference users = instance.collection('users');


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

}