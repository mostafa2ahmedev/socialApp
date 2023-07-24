import 'package:firebasepro/Features/Home/presentation/Manger/HomeCubit.dart';
import 'package:firebasepro/Features/Home/presentation/Manger/HomeStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BuildChatItem.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var userModel = HomeCubit.get(context).chats;
        return userModel!.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return BuildChatItem(
                    userModel: userModel[index],
                  );
                },
                separatorBuilder: (contex, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: userModel.length)
            : const Center(child: Text('No Chats Yet'));
      },
    );
  }
}
