import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MobileService {
  static var picker = ImagePicker();
  static Future<File?> getProfileImageFromGallary() async {
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path);
    } else {
      print('No image selected');
    }
    return null;
  }

////////////////////
  static Future<File?> getCoverImageFromGallary() async {
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path);
    } else {
      print('No image selected');
    }
    return null;
  }

///////////////////////////////
  static Future<File?> getPostImageFromGallary() async {
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path);
    } else {
      print('No image selected');
    }
    return null;
  }
}
