import 'package:firebasepro/Features/Auth/presenataion/Manger/AuthCubitStates.dart';
import 'package:firebasepro/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/AuthService.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.authService) : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);
  AuthService authService;
  IconData visibility = Icons.visibility_off;
  bool isVisibility = true;
//////////////////////

  void resetAuthCubit() {
    emit(AuthInitialState());
  }

  void changeVisibilityMode() {
    // كنا ممكن نعملها بطريقه تانيه عن طريق متغير واحد بس ترو وفولس
    // وهناك هنعمل كوندش الي هي ع الباراميتر نفسه  لو بترو  يبقي كذا ولو فولس يبقي كذا
    isVisibility = !isVisibility;
    if (isVisibility) {
      visibility = Icons.visibility_off;
    } else {
      visibility = Icons.visibility;
    }
    emit(ChangeVisibilityMode());
  }

///////////////////////////
  bool isLogin = false;

  void changeRemeberState() {
    isLogin = !isLogin;
    print(isLogin);
    emit(ChangeRemeberLoginState());
  }

//////////////////////
  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(RegisterLoadingState());
    try {
      authService.userRegisterWithEmail(
          name: name, email: email, password: password, phone: phone);
      emit(RegisterSuccessState());
    } catch (error) {
      emit(RegisterFailureState(error.toString()));
    }
  }

//////////////////////
  Future<void> userLogin({
    required String password,
    required String email,
  }) async {
    emit(LoginLoadingState());

    try {
      var userCredential = await authService.userLoginWithEmail(
          password: password, email: email);
      uId = userCredential.user!.uid;

      emit(LoginSuccessState(userCredential.user!.uid));
    } catch (error) {
      emit(LoginFailureState(error.toString()));
    }
  }

//////////////////////
  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    emit(CreateUserLoadingState());
    try {
      authService.userCreate(email: email, name: name, phone: phone, uId: uId);
      emit(CreateUserSuccessState());
    } catch (e) {
      emit(CreateUserFailureState(e.toString()));
    }
  }

//////////////////////////

  void userLoginWithGmail() async {
    emit(LoginLoadingGoogleState());
    try {
      var userCredential = await authService.userLoginWithGoogle();

      userCreate(
          email: userCredential.user!.email!,
          name: userCredential.user!.displayName!,
          phone: userCredential.user!.phoneNumber ?? 'null',
          uId: userCredential.user!.uid);

      emit(LoginSuccessCreateAcccountGoogleState(userCredential.user!.uid));
    } catch (e) {
      print(e.toString());
      emit(LoginFailureGoogleState(e.toString()));
    }
  }

  // void userLoginWithFacebook() async {
  //   emit(LoginLoadingFacebookState());
  //   try {
  //     var userCredential = await authService.userLoginWithFacebook();

  //     userCreate(
  //         email: userCredential.user!.email!,
  //         name: userCredential.user!.displayName!,
  //         phone: userCredential.user!.phoneNumber ?? 'null',
  //         uId: userCredential.user!.uid);

  //     emit(LoginSuccessFacebookState(userCredential.user!.uid));
  //   } catch (e) {
  //     print(e.toString());
  //     emit(LogingFailureacebookState(e.toString()));
  //   }
  // }
}






























 // void userRegister(
  //     {required String name,
  //     required String email,
  //     required String password,
  //     required String phone}) {
  //   emit(RegisterLoadingState());
  //   FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(email: email, password: password)
  //       .then(
  //     (value) {
  //       emit(RegisterSuccessState());
  //       userCreate(
  //           email: email, name: name, phone: phone, uId: value.user!.uid);
  //     },
  //   ).catchError(
  //     (error) {
  //       emit(RegisterFailureState(error.toString()));
  //     },
  //   );
  // }

  
  // void userLogin({
  //   required String password,
  //   required String email,
  // }) {
  //   emit(LoginLoadingState());
  //   FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email, password: password)
  //       .then(
  //     (value) {
  //       emit(LoginSuccessState(value.user!.uid));
  //     },
  //   ).catchError(
  //     (error) {
  //       emit(LoginFailureState(error.toString()));
  //     },
  //   );
  // }







//     UserModel? usermodel;
//   void userCreate({
//     required String email,
//     required String name,
//     required String phone,
//     required String uId,
//   }) {
//     // لو هتطلع داتا بره تخزنها ف داتا بيز نستخدم الكونستراكتور العادي اما لو هنجيب من بره نستخدم الفرو جسون
//     usermodel = UserModel(
//         email: email,
//         name: name,
//         phone: phone,
//         uId: uId,
//         bio: 'Write your bio here .....',
//         image:
//             'https://img.freepik.com/free-photo/man-relaxing-bench_1048-1608.jpg?w=740&t=st=1689619102~exp=1689619702~hmac=54b12fb1b8b0fbcf7202dac6ebfc4c5935f718a9172bee87e9dd5d68d93d6248',
//         cover:
//             'https://img.freepik.com/free-photo/man-relaxing-bench_1048-1608.jpg?w=740&t=st=1689619102~exp=1689619702~hmac=54b12fb1b8b0fbcf7202dac6ebfc4c5935f718a9172bee87e9dd5d68d93d6248',
//         isEmailVerfied: false);

//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(uId)
//         .set(usermodel!.toMap())
//         .then((value) {
//       emit(CreateUserSuccessState());
//     }).catchError((error) {
//       emit(CreateUserFailureState(error.toString()));
//     });
//   }
// }





