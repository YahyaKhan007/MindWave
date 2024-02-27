import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../upload_music_to_server/upload_status.dart';

class MusicUplaodFirebaseUtils {
  Future<String?> uploadAudioFile({
    required File audioFile,
    required String fileName,
    required void Function(double) onProgress,
  }) async {
    try {
      var controller = Get.put(UploadStatus());
      // Get a reference to the Firebase Storage location
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);

      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(audioFile);

      // Listen to the task snapshot events to get upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        controller.progressValue.value =
            (snapshot.bytesTransferred / snapshot.totalBytes);

        double progress = (snapshot.bytesTransferred / snapshot.totalBytes);
        onProgress(progress);
      }, onError: (Object e) {
        log("Error during upload: $e");
      });

      // Wait for the upload to complete and get the download URL
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
        // Get.back();
      });
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Return the download URL
      return downloadUrl;
    } catch (e) {
      log("Error uploading audio file: $e");
      return null;
    } finally {
      Get.back(); // Close the progress dialog after upload completion or error
    }
  }
}
