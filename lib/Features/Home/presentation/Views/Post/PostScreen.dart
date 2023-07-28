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
      listener: (context, state) {},
      builder: (context, state) {
        var postImage = HomeCubit.get(context).postImage;
        var userModel = HomeCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blueAccent,
            title: const Text(
              'Create Post',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  HomeCubit.get(context).uploadPost(
                      dateTime: DateTime.now().toString(),
                      postData: postController.text);

                  HomeCubit.get(context).currentIndex = 0;
                  Navigator.pop(context);
                },
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          body: state is GetUserLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
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
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(userModel!.image!),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      userModel.name!,
                                      style: const TextStyle(height: 1.4),
                                      // الهايت دا كويس لو حطيته 1 هيعملك مسافه من تحت كدا شويه  لو زاد عن 1   بينزلك اصلا كل التكيست من فوق بدل البادج يعني
                                    ),
                                  ],
                                ),
                                Text(
                                  DateTime.now().toString(),
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
                                HomeCubit.get(context)
                                    .getpostImageFromGallary();
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
