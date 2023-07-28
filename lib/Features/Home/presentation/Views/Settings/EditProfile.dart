import 'dart:io';

import 'package:firebasepro/Features/Home/presentation/Views/Settings/EditProfileAppBar.dart';
import 'package:firebasepro/Features/Home/presentation/Views/Settings/TextFieldProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../Manger/HomeCubit.dart';
import '../../Manger/HomeStates.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = HomeCubit.get(context).userModel;
        var profileImage = HomeCubit.get(context).profileImage;
        var coverImage = HomeCubit.get(context).coverImage;
        phoneController.text = usermodel!.phone!;
        nameController.text = usermodel.name!;
        bioController.text = usermodel.bio!;
        return Scaffold(
            appBar: const EditProfileAppBar(),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is UploadImageLodaingState)
                      const LinearProgressIndicator(),
                    SizedBox(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: (coverImage == null)
                                            ? NetworkImage('${usermodel.cover}')
                                            : FileImage(File(coverImage.path))
                                                as ImageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    HomeCubit.get(context)
                                        .getCoverImageFromGallary();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: (profileImage == null)
                                      ? NetworkImage('${usermodel.image}')
                                      : FileImage(File(profileImage.path))
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  HomeCubit.get(context)
                                      .getProfileImageFromGallary();
                                },
                                icon: const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        if (profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    HomeCubit.get(context).changeProfielImage();
                                  },
                                  child: const Text('Upload profile image'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (state is UpdateUserLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      HomeCubit.get(context).changeCoverImage();
                                    },
                                    child: const Text('Upload Cover image')),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (state is UpdateUserLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                    TextFieldProfile(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'plz enter your name ';
                          }
                          return null;
                        },
                        controller: nameController,
                        iconData: IconBroken.User,
                        label: 'Name'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldProfile(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'plz enter your bio ';
                          }
                          return null;
                        },
                        controller: bioController,
                        iconData: IconBroken.Edit,
                        label: 'bio'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldProfile(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'plz enter your phone ';
                          }
                          return null;
                        },
                        controller: phoneController,
                        iconData: IconBroken.Call,
                        label: 'Phone'),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            HomeCubit.get(context).updateUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                bio: bioController.text);
                          }
                        },
                        child: const Text(
                          'UPDATE',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
