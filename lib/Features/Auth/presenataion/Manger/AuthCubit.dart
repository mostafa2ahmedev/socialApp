import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepro/Features/Auth/presenataion/Manger/AuthCubitStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/UserModel.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  IconData visibility = Icons.visibility_off;
  bool isVisibility = true;

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

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        emit(RegisterSuccessState());
        userCreate(
            email: email, name: name, phone: phone, uId: value.user!.uid);
      },
    ).catchError(
      (error) {
        emit(RegisterFailureState(error.toString()));
      },
    );
  }

  void userLogin({
    required String password,
    required String email,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        emit(LoginSuccessState(value.user!.uid));
      },
    ).catchError(
      (error) {
        emit(LoginFailureState(error.toString()));
      },
    );
  }

  UserModel? usermodel;
  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
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

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(usermodel!.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserFailureState(error.toString()));
    });
  }
}
