import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import 'package:imataapp/common/upload_image/base_image_repositry.dart';

class ImageRepositry extends BaseImageRepositry {
  final firebase_storage.FirebaseStorage stor =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadImageForReport(String id, XFile image) async {
    await stor.ref('files/${id.toString()}').putFile(File(image.path));
  }
}
