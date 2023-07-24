import 'package:firebasepro/Features/Home/presentation/Manger/HomeCubit.dart';
import 'package:firebasepro/Features/Home/presentation/Views/widgets/CommentView.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../../data/PostModel.dart';

class BuildPost extends StatelessWidget {
  const BuildPost({super.key, this.postModel, required this.index});
  final PostModel? postModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    '${postModel!.image}',
                  ),
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
                            '${postModel!.name}',
                            style: const TextStyle(height: 1.4),
                            // الهايت دا كويس لو حطيته 1 هيعملك مسافه من تحت كدا شويه  لو زاد عن 1   بينزلك اصلا كل التكيست من فوق بدل البادج يعني
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16,
                          )
                        ],
                      ),
                      Text(
                        '${postModel!.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(size: 16, Icons.more_horiz),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${postModel!.postData}',
              style: const TextStyle(
                  height: 1.3, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 15),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                            minWidth: 1,
                            height: 25,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                              '#Software',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.blue),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                            height: 25,
                            onPressed: () {},
                            child: Text(
                              '#Flutter',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.blue),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (postModel!.postImage != 'empty')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: NetworkImage('${postModel!.postImage}   '),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const Icon(IconBroken.Heart,
                                size: 16, color: Colors.red),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              ' ${HomeCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(IconBroken.Chat,
                                size: 16, color: Colors.amber),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0 comments',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              '${HomeCubit.get(context).userModel!.image}'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              HomeCubit.get(context).getComments(
                                  postId:
                                      HomeCubit.get(context).postsId![index]);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return CommentVeiw(
                                  index: index,
                                );
                              })));
                            },
                            child: Text(
                              'Write a Comment ...',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(height: 1.4),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            HomeCubit.get(context).likePosts(
                                postId: HomeCubit.get(context).postsId![index]);
                          },
                          child: Row(
                            children: [
                              const Icon(IconBroken.Heart,
                                  size: 16, color: Colors.red),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Like',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
