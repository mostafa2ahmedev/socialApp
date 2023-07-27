import 'package:flutter/material.dart';

import '../../../../../../core/globalMethods.dart';
import '../../../../../Home/presentation/Views/HomeView.dart';
import '../../../../data/Cache,.dart';
import '../../../Manger/AuthCubit.dart';
import '../../../Manger/AuthCubitStates.dart';

void ListenerLogin(
    AuthStates state,
    BuildContext context,
    TextEditingController emailcontroller,
    TextEditingController passwordcontroller) {
  if (state is LoginFailureState) {
    GlobalMethod.showSnakeBar(context,
        text: state.error, backGroundColor: Colors.red);
  } else if (AuthCubit.get(context).isLogin == true &&
      state is LoginSuccessState) {
    Cache.saveData(key: 'uId', value: state.uId).then(
      (value) {
        GlobalMethod.navigatoReb(context, view: const HomeView());
      },
    );
  } else if (state is LoginSuccessState) {
    emailcontroller.clear();
    passwordcontroller.clear();
    GlobalMethod.navigatoReb(context, view: const HomeView());
  } else if (state is LoginSuccessCreateAcccountGoogleState) {
    Cache.saveData(key: 'uId', value: state.uId).then(
      (value) {
        GlobalMethod.navigatoReb(context, view: const HomeView());
      },
    );
  }
}
