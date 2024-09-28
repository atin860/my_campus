import 'package:flutter/material.dart';
import 'package:get/get.dart';




showToastMessage(String message) {
  // treeka 1
  // final snackBar = SnackBar(content: Text(message));
  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //tareeka 2
  Get.rawSnackbar(
      message: message,
      borderRadius: 10,
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10));
// tareeka 3
  // Get.snackbar(
  //   "heading",
  //   "Display the message here",
  //   snackPosition: SnackPosition.BOTTOM,
  //   colorText: Colors.white,
  //   backgroundColor: Colors.lightBlue,
  //   icon: const Icon(Icons.add_alert),
  // );
}

successMessage(String message) {
  Get.rawSnackbar(
      message: message,
      borderRadius: 10,
      backgroundColor: Colors.green,
      margin: EdgeInsets.all(10));
}