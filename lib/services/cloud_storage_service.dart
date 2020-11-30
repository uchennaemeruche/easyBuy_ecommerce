import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class CloudStorageService {
  Future<CloudStorageResult> uploadImage(
      {@required dynamic imageToUpload, @required String name}) async {
    var imageFileName = name + DateTime.now().millisecondsSinceEpoch.toString();
    try {
      FirebaseStorage _storage = FirebaseStorage.instance;
      final Reference firebaseStorageRef = _storage.ref().child(imageFileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);

      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

      print("Task Snapshot: $snapshot");

      var downloadUrl = await snapshot.ref.getDownloadURL();

      print("DOwnloadURL: $downloadUrl");
      return CloudStorageResult(
        imageUrls: [downloadUrl.toString()],
      );
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<CloudStorageResult> uploadImages(
      {List<dynamic> imageList, String name}) async {
    List<dynamic> imageUrls = [];

    for (dynamic imageFile in imageList) {
      var downloadUrl = await postImage(imageToUpload: imageFile, name: name);
      imageUrls.add(downloadUrl.toString());
      if (imageUrls.length == imageList.length) {}
    }
    return CloudStorageResult(imageUrls: imageUrls);
  }

  Future<String> postImage({String name, dynamic imageToUpload}) async {
    var imageFileName = name + DateTime.now().millisecondsSinceEpoch.toString();

    FirebaseStorage _storage = FirebaseStorage.instance;
    final Reference firebaseStorageRef = _storage.ref().child(imageFileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

class CloudStorageResult {
  final List<dynamic> imageUrls;

  CloudStorageResult({this.imageUrls});
}

// uploadTask.then((value) {
//   print("UPload Task: $value");
//   value.ref.getDownloadURL().then((url) {
//     print("DOwnload URL: $url");
//     downloadUrl = url;
//   });
//   print("Another URL: $downloadUrl");
// });
// print("Another URL2: $downloadUrl");
// return CloudStorageResult(
//   imageUrl: downloadUrl.toString(),
// );
