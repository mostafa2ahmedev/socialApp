import 'package:flutter/material.dart';

import '../../../../Auth/data/UserModel.dart';
import 'ChatDetails.dart';

class BuildChatItem extends StatelessWidget {
  const BuildChatItem({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => ChatDetails(userModel: userModel)),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                '${userModel.image}',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              '${userModel.name}',
              style: const TextStyle(height: 1.4),
              // الهايت دا كويس لو حطيته 1 هيعملك مسافه من تحت كدا شويه  لو زاد عن 1   بينزلك اصلا كل التكيست من فوق بدل البادج يعني
            ),
          ],
        ),
      ),
    );
  }
}
