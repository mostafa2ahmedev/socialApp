import 'package:firebase_core/firebase_core.dart';
import 'package:firebasepro/Features/Auth/data/Cache,.dart';

import 'package:firebasepro/Features/Auth/presenataion/views/AuthHome/AuthView.dart';
import 'package:firebasepro/Features/Feeds/presentation/Manger/HomeCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/BlocObserver.dart';

void main() async {
  await beforeRunApp();

  // Widget widget;
  // if (uId != null) {
  //   widget = const HomeView();
  // } else {
  //   widget = const LoginView();
  // }

  runApp(const FireBasePro(
      // startWidget: widget,
      ));
}

class FireBasePro extends StatelessWidget {
  const FireBasePro({
    super.key,
  });
  // final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getUserData()
        ..getPostData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthView(),
      ),
    );
  }
}

Future beforeRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {}
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print('ايوه هنا');
  //   print(event.data.toString());
  // });
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  //   print('la هنا');
  // });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await Cache.init();

  // uId = Cache.getData(key: 'uId');
}
