import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants.dart';
import '../../Auth/data/UserModel.dart';

class FireBaseFireStoreService {
  static Future<UserModel> getUserData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uId).get();

    return UserModel.fromJson(snapshot.data());
    // طالما الي هيرجع هيبقي معتمد علي داتا لسه هتيجي اصلا ف المستقبل ف هوا كمان  لازم يكون فيوتشر عشان تستناه من هناك
  }
}
