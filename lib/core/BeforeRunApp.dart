import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Features/Auth/data/Cache,.dart';
import 'BlocObserver.dart';
import 'constants.dart';

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

  uId = Cache.getData(key: 'uId');
}
