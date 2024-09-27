import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_campus/widget/toast_msg.dart';

class StorageService {
  static Future<String?> uploadFile(
    String path,
    String fileName, {
    required File? file,
  }) async {
    if (file == null) {
      showToastMessage("File not selected.");
      log("File not selected.");
      return null;
    }

    try {
      // Define the reference to the location where the file will be uploaded
      Reference ref = FirebaseStorage.instance.ref(path).child(fileName);

      // Start the upload process
      UploadTask uploadTask = ref.putFile(file);

      // Await the completion of the upload
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      log("File uploaded successfully: $downloadUrl");

      return downloadUrl;
    } catch (e) {
      // Catch any errors and log them  
      log("Error uploading file: $e");
      showToastMessage("Error uploading file: ${e.toString()}");
      return null;
    }
  }
}
