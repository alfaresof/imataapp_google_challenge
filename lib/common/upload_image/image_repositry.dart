import 'dart:io';

import 'package:cross_file/src/types/interface.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:imataapp/common/upload_image/base_image_repositry.dart';

class ImageRepositry extends BaseImageRepositry {
  final firebase_storage.FirebaseStorage stor =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadImageForReport(String id, XFile image) async {
    try {
      final result =
          await stor.ref('files/${id.toString()}').putFile(File(image.path));
      if (result != null) {}
    } catch (_) {}
  }

// @override
// Future<void> uploadImage(String id, XFile image) {
//   throw UnimplementedError();
// }
}
