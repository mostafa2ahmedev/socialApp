import 'package:firebasepro/Features/Home/presentation/Manger/HomeStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Manger/HomeCubit.dart';
import 'CommentItem.dart';

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
            commentModel!.clear();
            Navigator.pop(context);
            return false;
          },
          child: Scaffold(
              body: state is GetCommentLoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        commentModel!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 30,
                                  ),
                                  itemBuilder: (context, index) {
                                    return CommentItem(
                                      commentModel: commentModel[index],
                                    );
                                  },
                                  itemCount: commentModel.length,
                                ),
                              )
                            : const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 200),
                                  child: Text('No Comments'),
                                ),
                              ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
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
                                    postId:
                                        HomeCubit.get(context).postsId![index],
                                  );
                                  HomeCubit.get(context).getComments(
                                    postId:
                                        HomeCubit.get(context).postsId![index],
                                  );
                                  commentController.clear();
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
