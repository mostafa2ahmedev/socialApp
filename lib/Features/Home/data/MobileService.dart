import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MobileService {
  static File? profileImage;

  static var picker = ImagePicker();
  static Future<File?> getProfileImageFromGallary() async {
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      profileImage = File(image.path);
    } else {
      print('No image selected');
    }
    return profileImage;
  }

  static File? coverImage;

  static Future<File?> getCoverImageFromGallary() async {
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      coverImage = File(image.path);
    } else {
      print('No image selected');
    }
    return coverImage;
  }
}
