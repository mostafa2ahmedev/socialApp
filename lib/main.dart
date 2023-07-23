import 'package:firebasepro/Features/Feeds/presentation/Manger/HomeCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/Auth/presenataion/views/loginview/loginview.dart';
import 'Features/Feeds/presentation/Views/HomeView.dart';
import 'core/BeforeRunApp.dart';
import 'core/constants.dart';

void main() async {
  await beforeRunApp();

  Widget widget;
  if (uId != null) {
    widget = const HomeView();
  } else {
    widget = const LoginView();
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
      create: (context) => HomeCubit()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
