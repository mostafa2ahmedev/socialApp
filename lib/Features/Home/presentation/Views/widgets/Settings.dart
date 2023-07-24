import 'package:firebasepro/Features/Home/presentation/Views/widgets/EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../Manger/HomeCubit.dart';
import '../../Manger/HomeStates.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
                              image: NetworkImage(usermodel!.cover ?? ''),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(usermodel.image ?? ''),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                usermodel.name ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Janna'),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                usermodel.bio ?? '',
                style: TextStyle(
                    fontSize: 14, color: Colors.black.withOpacity(0.6)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              'Posts',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              'Photos',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              'Followings',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    )
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditProfile();
                            },
                          ),
                        );
                      },
                      child: const Icon(
                        IconBroken.Edit,
                        size: 16,
                      )),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
