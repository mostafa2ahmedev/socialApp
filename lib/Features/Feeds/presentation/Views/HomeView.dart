import 'package:firebasepro/Features/Feeds/presentation/Manger/HomeStates.dart';
import 'package:firebasepro/Features/Feeds/presentation/Views/widgets/PostScreen.dart';

import 'package:firebasepro/core/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import '../Manger/HomeCubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ChangePostState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PostScreen();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Janna'),
            ),
            titleTextStyle: Styles.titleStyleLight,
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Notification),
                color: Colors.black,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
                color: Colors.black,
              )
            ],
          ),
          body: cubit.scareens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              elevation: 20,
              unselectedItemColor: Colors.grey,
              currentIndex: cubit.currentIndex,
              onTap: (value) {
                cubit.changeBottomNav(value);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location), label: 'Location'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: 'Settings'),
              ]),
        );
      },
    );
  }
}