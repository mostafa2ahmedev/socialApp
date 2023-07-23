import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'UserModel.dart';

class AuthService {
  ///////////////
  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        userCreate(
            email: email, name: name, phone: phone, uId: value.user!.uid);
      },
    ).catchError(
      (error) {},
    );
  }

/////////////////////
  Future<UserCredential> userLogin({
    required String password,
    required String email,
  }) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  /////////////////////
  ///محتاج اشوف الفرق بين الاوبجكت لما يكون ينفع ياخد نل وبتاع الاوث سيرفر لما قالك مينفعش ب نل
  UserModel? usermodel;
  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) async {
    // لو هتطلع داتا بره تخزنها ف داتا بيز نستخدم الكونستراكتور العادي اما لو هنجيب من بره نستخدم الفرو جسون
    usermodel = UserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        bio: 'Write your bio here .....',
        image:
            'https://img.freepik.com/free-photo/man-relaxing-bench_1048-1608.jpg?w=740&t=st=1689619102~exp=1689619702~hmac=54b12fb1b8b0fbcf7202dac6ebfc4c5935f718a9172bee87e9dd5d68d93d6248',
        cover:
            'https://img.freepik.com/free-photo/man-relaxing-bench_1048-1608.jpg?w=740&t=st=1689619102~exp=1689619702~hmac=54b12fb1b8b0fbcf7202dac6ebfc4c5935f718a9172bee87e9dd5d68d93d6248',
        isEmailVerfied: false);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(usermodel!.toMap());
  }
}
