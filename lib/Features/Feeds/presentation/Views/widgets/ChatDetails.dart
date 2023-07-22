import 'package:firebasepro/Features/Auth/data/UserModel.dart';
import 'package:firebasepro/Features/Feeds/data/ChatModel.dart';
import 'package:firebasepro/Features/Feeds/presentation/Manger/HomeCubit.dart';
import 'package:firebasepro/Features/Feeds/presentation/Manger/HomeStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

class ChatDetails extends StatelessWidget {
  ChatDetails({super.key, required this.userModel});
  final UserModel userModel;
  final TextEditingController textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return // البلدر دي بتخليك تستدعي حاجه قبل ما تبدا  الكونسيومر
        Builder(
      builder: (context) {
        HomeCubit.get(context).getMessage(recieverId: userModel.uId!);
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text('${userModel.name}')
                    ],
                  ),
                  titleSpacing: 0,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      HomeCubit.get(context).messages!.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    var message =
                                        HomeCubit.get(context).messages;
                                    if (HomeCubit.get(context).userModel!.uId ==
                                        message![index].senderId) {
                                      return BuildMyChat(
                                        messageModel: message[index],
                                      );
                                    } else {
                                      return BuildOtherChat(
                                          messageModel: message[index]);
                                    }
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 15,
                                    );
                                  },
                                  itemCount:
                                      HomeCubit.get(context).messages!.length),
                            )
                          : const Center(
                              child: Text('No Messages yet '),
                            ),
                      const Spacer(),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textcontroller,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here '),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.blue,
                              child: MaterialButton(
                                minWidth: 1,
                                onPressed: () {
                                  HomeCubit.get(context).sendMessage(
                                    dateTime: DateTime.now().toString(),
                                    text: textcontroller.text,
                                    recieverId: userModel.uId!,
                                  );
                                },
                                child: const Icon(
                                  IconBroken.Send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        );
      },
    );
  }
}

class BuildOtherChat extends StatelessWidget {
  const BuildOtherChat({
    super.key,
    required this.messageModel,
  });
  final ChatModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
        ),
        child: Text('${messageModel.text}'),
      ),
    );
  }
}

class BuildMyChat extends StatelessWidget {
  const BuildMyChat({
    super.key,
    required this.messageModel,
  });
  final ChatModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
        ),
        child: Text('${messageModel.text}'),
      ),
    );
  }
}
