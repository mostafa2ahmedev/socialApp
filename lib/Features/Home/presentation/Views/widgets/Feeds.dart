import 'package:firebasepro/Features/Home/presentation/Manger/HomeCubit.dart';
import 'package:firebasepro/Features/Home/presentation/Manger/HomeStates.dart';
import 'package:firebasepro/core/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BuildPost.dart';

class FeedsView extends StatelessWidget {
  const FeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var posts = HomeCubit.get(context).posts;

        return posts.isNotEmpty
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      margin: const EdgeInsets.all(8),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          const Image(
                            height: 200,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            image: NetworkImage(
                                'https://img.freepik.com/premium-photo/two-business-people-shaking-hands-generative-ai_10221-24720.jpg?w=1380'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text('Communicate With Friends',
                                style: Styles.bodyMeduimStyleLight),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemBuilder: (context, index) {
                        return BuildPost(postModel: posts[index], index: index);
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: posts.length,
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
