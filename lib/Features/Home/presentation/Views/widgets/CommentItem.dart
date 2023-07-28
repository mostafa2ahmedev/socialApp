import 'package:flutter/material.dart';

import '../../../data/CommentModel.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.commentModel});
  final CommentModel commentModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            commentModel.name!,
            style: const TextStyle(
                color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          elevation: 5,
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  '${commentModel.image}',
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 9,
                  ),
                  Text(
                    '${commentModel.commentData}',
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
