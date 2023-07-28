import 'package:firebasepro/Features/Auth/presenataion/views/AuthHome/AuthView.dart';
import 'package:firebasepro/Features/Home/presentation/Manger/HomeCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/Home/presentation/Views/HomeView.dart';
import 'core/BeforeRunApp.dart';
import 'core/constants.dart';

void main() async {
  await beforeRunApp();

  Widget widget;
  if (uId != null) {
    widget = const HomeView();
  } else {
    widget = AuthView();
  }

  runApp(FireBasePro(
    startWidget: widget,
  ));
}

class FireBasePro extends StatelessWidget {
  const FireBasePro({
    super.key,
    required this.startWidget,
  });
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getUserData()
        ..getPostData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
