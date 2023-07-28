import 'package:firebasepro/Features/Home/presentation/Views/Settings/CustomRowInfo.dart';
import 'package:firebasepro/Features/Home/presentation/Views/Settings/EditProfile.dart';
import 'package:firebasepro/core/globalMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../../../Auth/presenataion/Manger/AuthCubit.dart';
import '../../Manger/HomeCubit.dart';
import '../../Manger/HomeStates.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, this.authcubit, this.homecubit});
  final AuthCubit? authcubit;
  final HomeCubit? homecubit;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var usermodel = HomeCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4)),
                          image: DecorationImage(
                              image: NetworkImage(usermodel!.cover!),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(usermodel.image!),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                usermodel.name!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Janna'),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                usermodel.bio!,
                style: TextStyle(
                    fontSize: 14, color: Colors.black.withOpacity(0.6)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    CustomRowInfo(text: '100', text2: 'Posts'),
                    CustomRowInfo(text: '100', text2: 'photos'),
                    CustomRowInfo(text: '100', text2: 'Followers'),
                    CustomRowInfo(text: '100', text2: 'Followings'),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text('Add Photos')),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      GlobalMethod.navigato(context, view: EditProfile());
                    },
                    child: const Icon(
                      IconBroken.Edit,
                      size: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
