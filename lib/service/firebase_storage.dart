import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_campus/widget/toast_msg.dart';

class StorageService {
  Future<void> uploadUserProfileImage(String userId) async {
    final ImagePicker picker = ImagePicker();

    try {
      // Pick an image from the gallery
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

      if (photo == null) {
        debugPrint("No image selected.");
        return;
      }

      File imageFile = File(photo.path);

      // Define the file path in Firebase Storage
      String filePath = "profilePictures/$userId-profile.jpg";

      // Upload the image to Firebase Storage
      UploadTask uploadTask =
          FirebaseStorage.instance.ref(filePath).putFile(imageFile);

      // Get the download URL after the upload is complete
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update the Firestore user document with the image URL
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        "image": downloadUrl,
      });

      debugPrint("Image uploaded successfully: $downloadUrl");
    } catch (e) {
      debugPrint("Error uploading image: $e");
    }
  }
}
