import 'package:firebasepro/Features/Home/presentation/Manger/HomeCubit.dart';
import 'package:firebasepro/Features/Home/presentation/Manger/HomeStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});
  final TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var postImage = HomeCubit.get(context).postImage;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Create Post',
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (postImage != null) {
                    HomeCubit.get(context).uploadPostImage(
                        dateTime: DateTime.now().toString(),
                        postData: postController.text);
                  } else {
                    HomeCubit.get(context).createPost(
                        dateTime: DateTime.now().toString(),
                        postData: postController.text);
                  }
                  HomeCubit.get(context).getPostData();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (state is CreatePostLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/medium-shot-woman-wearing-vr-glasses_23-2150394457.jpg?w=996&t=st=1689553940~exp=1689554540~hmac=3018f2d54c6fec55cb1f74616978f29363aaf6ab3a57f7484ac6d06a56dec1ad'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Mostafa Ahmed',
                                style: TextStyle(height: 1.4),
                                // الهايت دا كويس لو حطيته 1 هيعملك مسافه من تحت كدا شويه  لو زاد عن 1   بينزلك اصلا كل التكيست من فوق بدل البادج يعني
                              ),
                            ],
                          ),
                          Text(
                            'January 21, 2021 at 11:00 pm',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: const InputDecoration(
                      hintText: 'what is on your mind...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if (postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
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
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                    image: FileImage(postImage),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                HomeCubit.get(context).removePostImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          HomeCubit.get(context).getpostImageFromGallary();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            Text(
                              'add photo',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '# tags',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
