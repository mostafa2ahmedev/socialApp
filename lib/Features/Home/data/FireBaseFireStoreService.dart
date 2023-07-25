import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../core/constants.dart';
import '../../Auth/data/UserModel.dart';

class FireBaseFireStoreService {
////////////////////////////
///////////////////////////
  static Future<UserModel> getUserData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uId).get();

    return UserModel.fromJson(snapshot.data());
    // طالما الي هيرجع هيبقي معتمد علي داتا لسه هتيجي اصلا ف المستقبل ف هوا كمان  لازم يكون فيوتشر عشان تستناه من هناك
  }

////////////////////////////
///////////////////////////
  static Future<String?> uploadProfileImage({
    required File? profileImage,
  }) async {
    var file = await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage);
    return await file.ref.getDownloadURL();
  }

////////////////////////////
///////////////////////////
  static Future<String?> uploadCoverImage({
    required File? coverImage,
  }) async {
    var file = await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage);
    return await file.ref.getDownloadURL();
  }

////////////////////////////
///////////////////////////
  static void updateUser({
    String? name,
    String? phone,
    String? bio,
    UserModel? userModel,
    String? cover,
    String? image,
  }) async {
    UserModel usermodel = UserModel(
      email: userModel!.email,
      isEmailVerfied: userModel.isEmailVerfied,
      name: name!,
      bio: bio!,
      phone: phone!,
      uId: userModel.uId,
      image: image ?? userModel.image,
      cover: cover ?? userModel.cover,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(usermodel.toMap());
  }
////////////////////////////
///////////////////////////
}
