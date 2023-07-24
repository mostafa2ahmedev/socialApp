import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants.dart';
import '../../Auth/data/UserModel.dart';

class FireBaseFireStoreService {
  static void getUserData() {
    UserModel? userModel;
    FirebaseFirestore.instance.collection('users').doc(uId).get().then(
      (value) {
        userModel = UserModel.fromJson(value.data());
      },
    ).catchError(
      (error) {},
    );
  }
}
