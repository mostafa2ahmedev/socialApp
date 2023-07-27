import 'dart:io';

import 'package:firebasepro/Features/Auth/data/UserModel.dart';
import 'package:firebasepro/Features/Home/data/ChatModel.dart';
import 'package:firebasepro/Features/Home/data/CommentModel.dart';
import 'package:firebasepro/Features/Home/data/FireBaseFireStoreService.dart';
import 'package:firebasepro/Features/Home/data/MobileService.dart';
import 'package:firebasepro/Features/Home/data/PostModel.dart';
import 'package:firebasepro/Features/Home/presentation/Manger/HomeStates.dart';

import 'package:firebasepro/Features/Home/presentation/Views/Settings/Settings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Views/Post/PostScreen.dart';
import '../Views/widgets/Chats.dart';
import '../Views/widgets/Feeds.dart';
import '../Views/widgets/Users.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitailState());

  static HomeCubit get(context) => BlocProvider.of(context);
//////////////////////////////////////////
/////////////////////////////////////////
  var picker = ImagePicker();
  void resetHomeCubit() {
    emit(HomeInitailState());
  }

  int currentIndex = 0;
  List<Widget> scareens = [
    const FeedsView(),
    const ChatsView(),
    PostScreen(),
    const UsersView(),
    const SettingsView()
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index) {
    if (index == 1) {
      // فيه حاجه غريبه هنا وهي ان الكارنت اندكس الي انا بغير بناء عليه هناك مش بيتغير ولكن السكرين بالعلامه بتتغير
      getALLUsers();
      // currentIndex = index;
      print(index);
      print(currentIndex);
    }
    if (index == 2) {
      emit(ChangePostState());
    } else {
      currentIndex = index;
      emit(ChangeNavState());
    }
  }

//////////////////////////////////////////
/////////////////////////////////////////
  UserModel? userModel;

  void getUserData() async {
    try {
      emit(GetUserLoadingState());
      userModel = await FireBaseFireStoreService.getUserData();
      emit(GetUserSuccessState());
    } catch (e) {
      emit(GetUserFailureState(e.toString()));
    }
  }

//////////////////////////////////////////
/////////////////////////////////////////
  File? profileImage;

  void getProfileImageFromGallary() async {
    try {
      profileImage = await MobileService.getProfileImageFromGallary();
      emit(ChangeProfileImageSuccesstate());
    } catch (e) {
      print('No image selected');
      emit(ChangeProfileImageFailurState());
    }
  }

//////////////////////////////////////////
/////////////////////////////////////////
  File? coverImage;

  void getCoverImageFromGallary() async {
    try {
      coverImage = await MobileService.getProfileImageFromGallary();
      emit(ChangeCoverImageSuccesstate());
    } catch (e) {
      print('No image selected');
      emit(ChangeCoverImageFailurState());
    }
  }

//////////////////////////////////////////
/////////////////////////////////////////
  void changeProfielImage() async {
    emit(UploadImageLodaingState());
    try {
      var image = await FireBaseFireStoreService.uploadProfileImage(
        profileImage: profileImage,
      );

      FireBaseFireStoreService.updateUser(image: image, userModel: userModel!);

      userModel = await FireBaseFireStoreService.getUserData();

      emit(UploadProfileImageSuccesstate());
    } catch (e) {
      emit(UploadProfileImageFailurState());
    }
  }

//////////////////////////////////////////
/////////////////////////////////////////
  void changeCoverImage() async {
    emit(UploadImageLodaingState());
    try {
      var image = await FireBaseFireStoreService.uploadCoverImage(
        coverImage: coverImage,
      );

      FireBaseFireStoreService.updateUser(cover: image, userModel: userModel!);
      userModel = await FireBaseFireStoreService.getUserData();
      emit(UploadCoverImageSuccesstate());
    } catch (e) {
      emit(UploadCoverImageFailurState());
    }
  }

//////////////////////////////////////////
/////////////////////////////////////////
  void updateUserData(
      {required String name,
      required String bio,
      required String phone}) async {
    emit(UpdateUserLoadingState());

    try {
      FireBaseFireStoreService.updateUser(
          name: name, bio: bio, phone: phone, userModel: userModel);

      userModel = await FireBaseFireStoreService.getUserData();
      emit(UpdateUserSuccessState());
    } catch (e) {
      emit(UpdateUserFailurState());
    }
  }

/////////////////////////////////////////
/////////////////////////////////////////

  File? postImage;

  Future<void> getpostImageFromGallary() async {
    try {
      postImage = await MobileService.getPostImageFromGallary();
      emit(ChangePostImageSuccessState());
    } catch (e) {
      emit(ChangePostImageFailurState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImage());
  }

  void uploadPost({
    required String dateTime,
    required String postData,
  }) async {
    emit(CreatePostLoadingState());
    try {
      String? image;
      if (postImage != null) {
        image = await FireBaseFireStoreService.uploadPostImage(
            postImage: postImage);
      }

      FireBaseFireStoreService.createPost(
          dateTime: dateTime,
          postData: postData,
          postImage: image,
          userModel: userModel!);

      FireBaseFireStoreService.getPostData();
      emit(CreatePostSuccessState());
    } catch (e) {
      emit(CreatePostFailureState());
    }
  }
/////////////////////////////////
////////////////////////////////

///////////////////////////////////////////
/////////////////////////////////
  List<PostModel> posts = [];
  List<String>? postsId = [];
  List<int> likes = [];
  void getPostData() async {
    emit(GetPostLoadingState());
    try {
      var postData = await FireBaseFireStoreService.getPostData();
      posts = postData.posts;
      postsId = postData.postsId;
      likes = postData.likes;
      emit(GetPostSuccessState());
    } catch (e) {
      emit(GetPostFailureState(e.toString()));
    }
  }

////////////////////////////////
//////////////////////////////
  void likePosts({required String postId}) {
    try {
      FireBaseFireStoreService.likePosts(userModel: userModel!, postId: postId);
      emit(LikePostSuccessState());
    } catch (e) {
      LikePostFailureState(e.toString());
    }
  }

////////////////////////////////
//////////////////////////////
  void commentPost({String? postId, required String comment}) {
    try {
      FireBaseFireStoreService.commentPost(
          comment: comment, userModel: userModel!, postId: postId);
      emit(CommentPostSuccessState());
    } catch (e) {
      emit(CommentPostFailureState(e.toString()));
    }
  }

////////////////////////////////
//////////////////////////////
  List<CommentModel>? commentModel = [];
  void getComments({required String? postId}) {
    try {
      FireBaseFireStoreService.getComments(postId: postId);
      emit(GetCommentSuccessState());
    } catch (e) {
      emit(GetCommentFailureState(e.toString()));
    }
  }

  List<UserModel>? chats = [];
  void getALLUsers() async {
    emit(GetAllUsersLoadingState());

    try {
      chats = await FireBaseFireStoreService.getALLUsers(userModel: userModel!);
      emit(GetAllUsersSuccessState());
    } catch (e) {
      emit(GetAllUsersFailureState(e.toString()));
    }
  }

  void sendMessage({
    required String dateTime,
    required String text,
    required String recieverId,
  }) {
    try {
      FireBaseFireStoreService.sendMessage(
          dateTime: dateTime,
          text: text,
          recieverId: recieverId,
          userModel: userModel!);
      emit(SendMessageSuccessState());
    } catch (e) {
      emit(SendMessageFailureState(e.toString()));
    }
  }

  List<ChatModel>? messages = [];
  void getMessage({
    required String recieverId,
  }) {
    try {
      FireBaseFireStoreService.getMessage(
          recieverId: recieverId, userModel: userModel!);
      emit(GetMessageSuccessState());
    } catch (e) {
      emit(GetMessageFailureState(e.toString()));
    }
  }
}
