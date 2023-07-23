import 'package:firebasepro/Features/Auth/data/AuthService.dart';
import 'package:firebasepro/Features/Auth/presenataion/Manger/AuthCubit.dart';
import 'package:firebasepro/Features/Auth/presenataion/views/loginview/widgets/LoginViewBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) => AuthCubit(AuthService()),
          child: LoginViewBody(),
        ),
      ),
    );
  }
}
