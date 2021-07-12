import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class CloudStorageService {
  final StreamController<double> _progressController =
      StreamController<double>.broadcast();

  Stream<double> get uploadProgress => _progressController.stream;

  Future<CloudStorageResult> uploadImage({
    required File imageToUpload,
    required String id,
    bool isProfile = false,
  }) async {
    if (imageToUpload != null) {
      var imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

      final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
          isProfile ? 'profile/$id/$imageFileName' : 'post/$id/$imageFileName');

      UploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
      _progressController.add(0);
      uploadTask.snapshotEvents.listen((event) {
        if (event.state == TaskState.running) {
          final double progress = event.bytesTransferred / event.totalBytes;
          _progressController.add(progress);
          print(progress);
        }
      });

      String downloadUrl = "";
      await uploadTask
          .then((ts) async => downloadUrl = await ts.ref.getDownloadURL());

      var url = downloadUrl.toString();
      return CloudStorageResult(
        imageUrl: url,
        imageFileName: imageFileName,
      );
    } else {
      return CloudStorageResult(
        imageUrl: '',
        imageFileName: '',
      );
    }
  }

  Future deleteImage(String imgeUrl) async {
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.refFromURL(imgeUrl);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getDownloadUrl(String imagePath) async {
    final firebaseStorageRef = FirebaseStorage.instance.ref().child(imagePath);

    try {
      var url = await firebaseStorageRef.getDownloadURL();
      return url;
    } catch (e) {
      return e.toString();
    }
  }
}

class CloudStorageResult {
  final String imageUrl;
  final String imageFileName;

  CloudStorageResult({required this.imageUrl, required this.imageFileName});
}
