import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

import '../Views/widgets/Chats.dart';
import '../Views/widgets/Feeds.dart';
import '../Views/widgets/PostScreen.dart';
import '../Views/widgets/Users.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(GetUserInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
//////////////////////////////////////////
/////////////////////////////////////////
  var picker = ImagePicker();

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
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      postImage = File(image.path);

      emit(UploadPostImageSuccesstate());
    } else {
      print('No image selected');
      emit(UploeadPostImageFailurState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String postData,
  }) {
    emit(CreatePostLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, postData: postData, postImage: value);
      }).catchError((error) {
        emit(CreatePostFailureState());
      });
    }).catchError((error) {
      emit(CreatePostFailureState());
    });
  }

  void createPost({
    required String dateTime,
    required String postData,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel postModel = PostModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image: userModel!.image,
        dateTime: dateTime,
        postData: postData,
        postImage: postImage ?? 'empty');
// الفرق بين  الست والادد ان الست بيشتغل ع الدوك معين ويحط تحته الداتا لكن الادد  بيعمل دوك عشوائي ويحط الداتا
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostFailureState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImage());
  }

///////////////////////////////////////////
/////////////////////////////////
  List<PostModel>? posts = [];
  List<String>? postsId = [];
  List<int> likes = [];
  // void getPostData() {
  //   emit(GetPostLoadingState());
  //   FirebaseFirestore.instance.collection('posts').get().then(
  //     (value) {
  //       for (var element in value.docs) {
  //         element.reference.collection('Likes').get().then((value) {
  //           likes.add(value.docs.length);
  //           postsId!.add(element.id);
  //           posts!.add(PostModel.fromJson(element.data()));
  //         }).catchError(
  //           (error) {
  //             emit(GetPostFailureState(error.toString()));
  //           },
  //         );
  //       }
  //       emit(GetPostSuccessState());
  //     },
  //   ).catchError(
  //     (error) {
  //       print(error.toString());
  //       emit(GetPostFailureState(error.toString()));
  //     },
  //   );
  // }
  void getPostData() {
    emit(GetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      // Create a list of Futures that represent the async operations to wait for
      final futures = value.docs.map((element) {
        return element.reference.collection('Likes').get().then((value) {
          likes.add(value.docs.length);
          postsId!.add(element.id);
          posts!.add(PostModel.fromJson(element.data()));
        });
      });

      // Wait for all the async operations to complete before emitting the success event
      Future.wait(futures).then((_) {
        emit(GetPostSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(GetPostFailureState(error.toString()));
    });
  }

////////////////////////////////
//////////////////////////////
  void likePosts({String? postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel!.uId)
        .set({'Like': true}).then(
      (value) {
        emit(LikePostSuccessState());
      },
    ).catchError(
      (error) {
        emit(
          LikePostFailureState(error.toString()),
        );
      },
    );
  }

  void commentPost({String? postId, required String comment}) {
    CommentModel commentModel = CommentModel(
        name: userModel!.name,
        dateTime: DateTime.now().toString(),
        image: userModel!.image,
        commentData: comment,
        uId: userModel!.uId);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(
          commentModel.toMap(),
        )
        .then(
      (value) {
        emit(CommentPostSuccessState());
      },
    ).catchError(
      (error) {
        emit(CommentPostFailureState(error.toString()));
      },
    );
  }

  List<CommentModel>? commentModel = [];

  void getComments({required String? postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
      for (var element in value.docs) {
        commentModel!.add(CommentModel.fromJson(element.data()));
      }
      emit(GetCommentSuccessState());
    }).catchError(
      (error) {
        emit(GetCommentFailureState(error.toString()));
      },
    );
  }

  List<UserModel>? chats = [];
  void getALLUsers() {
    if (chats!.isEmpty) {
      emit(GetAllUsersLoadingState());
      FirebaseFirestore.instance.collection('users').get().then(
        (value) {
          for (var element in value.docs) {
            if (userModel!.uId == element.data()['uId']) {
              continue;
            }
            chats!.add(UserModel.fromJson(element.data()));
          }
          emit(GetAllUsersSuccessState());
        },
      ).catchError(
        (error) {
          emit(GetAllUsersFailureState(error.toString()));
        },
      );
    }
  }

  void sendMessage({
    required String dateTime,
    required String text,
    required String recieverId,
  }) {
    ChatModel chatModel = ChatModel(
      text: text,
      dataTime: dateTime,
      recieverId: recieverId,
      senderId: userModel!.uId,
    );
    // my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(chatModel.toMap())
        .then(
      (value) {
        emit(SendMessageSuccessState());
      },
    ).catchError(
      (error) {
        emit(SendMessageFailureState(error.toString()));
      },
    );
    // reciever chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(chatModel.toMap())
        .then(
      (value) {
        emit(SendMessageSuccessState());
      },
    ).catchError(
      (error) {
        emit(SendMessageFailureState(error.toString()));
      },
    );
  }

  List<ChatModel>? messages = [];
  void getMessage({
    required String recieverId,
  }) {
    // الفويتشر هي داتا جايه كمان شويه لكن الستريم  هي طابور من الفيوتشر الي جايه كمان شويه  يعني هتبقي ريل تايم بمجرد ما تعمل حاجه هيدهلك علطلول
    // الفيوتشر بيجيب الداتا مره واحده كل ما تقوله ويقف  لكن الستريك مجرد ما تقوله هات الداتا مره هيبفضل متابع لها اي تغيير يجيبه تاني
    // بس خد بالك الليسن مجرد ما حاجه جديده تحصل هيلسن من الاول خالص  ف هيديك القديم تاني والجديد وهكئا ف لازم تصفر الليسته
    messages = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        var lastDocument = event.docs.last;

        messages!.add(ChatModel.fromJson(lastDocument.data()));

        emit(GetMessageSuccessState());
      }
    });
    // الستريم مفيهوش سكسس وايرور هي حاجه واحده لانه بيلسن جاب جاب مجابش مجابش
  }
}
















  // void getUserData() {
  //   emit(GetUserLoadingState());
  //   FirebaseFirestore.instance.collection('users').doc(uId).get().then(
  //     (value) {
  //       userModel = UserModel.fromJson(value.data());
  //       emit(GetUserSuccessState());
  //     },
  //   ).catchError(
  //     (error) {
  //       emit(GetUserFailureState(error.toString()));
  //     },
  //   );
  // }
  
  // Future<void> getProfileImageFromGallary() async {
  //   final image = await picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     profileImage = File(image.path);

  //     emit(ChangeProfileImageSuccesstate());
  //   } else {
  //     print('No image selected');
  //     emit(ChangeProfileImageFailurState());
  //   }
  // }
  //   Future<void> getCoverImageFromGallary() async {
  //   final image = await picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     coverImage = File(image.path);

  //     emit(ChangeProfileImageSuccesstate());
  //   } else {
  //     print('No image selected');
  //     emit(ChangeProfileImageFailurState());
  //   }
  // }
  // void uploadProfileImage({
  // required String name,
  // required String? phone,
  // required String? bio,
  // }) {
  //   emit(UpdateUserLoadingState());
  //   FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
  //       .putFile(profileImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       // emit(UploadProfileImageSuccesstate());

  //       updateUser(name: name, phone: phone, bio: bio, image: value);
  //     }).catchError((error) {
  //       emit(UploeadProfileImageFailurState());
  //     });
  //   }).catchError((error) {
  //     emit(UploeadProfileImageFailurState());
  //   });
  // }

   // void uploadcoverImage({
  //   required String name,
  //   required String? phone,
  //   required String? bio,
  // }) {
  //   emit(UpdateUserLoadingState());
  //   FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
  //       .putFile(coverImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       emit(UploadCoverImageSuccesstate());

  //       updateUser(name: name, phone: phone, bio: bio, cover: value);
  //     }).catchError((error) {
  //       emit(UploeadCoverImageFailurState());
  //     });
  //   }).catchError((error) {
  //     emit(UploeadCoverImageFailurState());
  //   });
  // }


  // void updateUser({
  //   required String name,
  //   required String? phone,
  //   required String? bio,
  //   String? cover,
  //   String? image,
  // }) {
  //   UserModel usermodel = UserModel(
  //     name: name,
  //     phone: phone,
  //     bio: bio,
  //     isEmailVerfied: false,
  //     email: userModel!.email,
  //     uId: userModel!.uId,
  //     image: image ?? userModel!.image,
  //     cover: cover ?? userModel!.cover,
  //   );

  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userModel!.uId)
  //       .update(usermodel.toMap())
  //       .then((value) {
  //     getUserData();
  //   }).catchError((error) {
  //     emit(UpdateUserFailurState());
  //   });
  // }