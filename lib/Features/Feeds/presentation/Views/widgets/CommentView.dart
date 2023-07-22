import 'package:firebasepro/Features/Feeds/presentation/Manger/HomeStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Manger/HomeCubit.dart';

class CommentVeiw extends StatelessWidget {
  CommentVeiw({super.key, required this.index});
  final int index;
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var commentModel = HomeCubit.get(context).commentModel;

        return WillPopScope(
          onWillPop: () async {
            commentModel.clear();
            Navigator.pop(context);
            return false;
          },
          child: Scaffold(
              body: Column(
            children: [
              commentModel!.isNotEmpty
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    '${commentModel[index].image}',
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                  ),
                                  child: Text(
                                    '${commentModel[index].commentData}',
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: commentModel.length,
                        ),
                      ),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: CircularProgressIndicator(),
                      ),
                    ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        HomeCubit.get(context).userModel!.image ?? '',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Write a Comment',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        HomeCubit.get(context).commentPost(
                          comment: commentController.text,
                          postId: HomeCubit.get(context).postsId![index],
                        );
                      },
                      icon: const Icon(Icons.comment_rounded),
                    )
                  ],
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
