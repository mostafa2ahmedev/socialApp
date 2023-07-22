// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebasepro/Features/Home/presentation/Manger/HomeCubit.dart';
// import 'package:firebasepro/Features/Home/presentation/Manger/HomeStates.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeViewBody extends StatelessWidget {
//   const HomeViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomeStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var model = HomeCubit.get(context).userModel;
//         return model != null
//             ? Column(
//                 children: [
//                   //!FirebaseAuth.instance.currentUser!.emailVerified
//                   if (!FirebaseAuth.instance.currentUser!.emailVerified)
//                     Container(
//                       color: Colors.amber.withOpacity(0.6),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           children: [
//                             const Icon(Icons.info_outline),
//                             const SizedBox(
//                               width: 20,
//                             ),
//                             const Text('Please verfiy your email '),
//                             const Spacer(),
//                             const SizedBox(
//                               width: 20,
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 FirebaseAuth.instance.currentUser!
//                                     .sendEmailVerification()
//                                     .then((value) {})
//                                     .catchError((error) {});
//                               },
//                               child: const Text('SEND'),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               )
//             : const CircularProgressIndicator();
//       },
//     );
//   }
// }
