import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasepro/Features/Home/data/PostData.dart';

import '../../../core/constants.dart';
import '../../Auth/data/UserModel.dart';
import 'ChatModel.dart';
import 'CommentModel.dart';
import 'PostModel.dart';

class FireBaseFireStoreService {
////////////////////////////
///////////////////////////
  static Future<UserModel> getUserData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uId).get();

    return UserModel.fromJson(snapshot.data());
    // طالما الي هيرجع هيبقي معتمد علي داتا لسه هتيجي اصلا ف المستقبل ف هوا كمان  لازم يكون فيوتشر عشان تستناه من هناك
  }

////////////////////////////
///////////////////////////
  static Future<String?> uploadProfileImage({
    required File? profileImage,
  }) async {
    var file = await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage);
    return await file.ref.getDownloadURL();
  }

////////////////////////////
///////////////////////////
  static Future<String?> uploadCoverImage({
    required File? coverImage,
  }) async {
    var file = await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage);
    return await file.ref.getDownloadURL();
  }

////////////////////////////
///////////////////////////
  static void updateUser({
    String? name,
    String? phone,
    String? bio,
    UserModel? userModel,
    String? cover,
    String? image,
  }) async {
    UserModel usermodel = UserModel(
      email: userModel!.email,
      isEmailVerfied: userModel.isEmailVerfied,
      name: name ?? userModel.name,
      bio: bio ?? userModel.bio,
      phone: phone ?? userModel.phone,
      uId: userModel.uId,
      image: image ?? userModel.image,
      cover: cover ?? userModel.cover,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(usermodel.toMap());
  }
////////////////////////////
///////////////////////////

  static Future<String?> uploadPostImage({required File? postImage}) async {
    var value = await FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage);
    return await value.ref.getDownloadURL();
  }

  ////////////////////////////
///////////////////////////
  static void createPost({
    required String dateTime,
    required String postData,
    String? postImage,
    required UserModel userModel,
  }) async {
    PostModel postModel = PostModel(
        name: userModel.name,
        uId: userModel.uId,
        image: userModel.image,
        dateTime: dateTime,
        postData: postData,
        postImage: postImage ?? 'empty');
// الفرق بين  الست والادد ان الست بيشتغل ع الدوك معين ويحط تحته الداتا لكن الادد  بيعمل دوك عشوائي ويحط الداتا
    await FirebaseFirestore.instance.collection('posts').add(postModel.toMap());
  }

  ////////////////////////////
///////////////////////////
  static Future<PostData> getPostData() async {
    List<PostModel> posts = [];
    List<String>? postsId = [];
    List<int> likes = [];
    var postList = await FirebaseFirestore.instance.collection('posts').get();

    for (var element in postList.docs) {
      posts.add(PostModel.fromJson(element.data()));
      var value = await element.reference.collection('Likes').get();
      likes.add(value.docs.length);
      postsId.add(element.id);
    }
    return PostData(posts: posts, postsId: postsId, likes: likes);
  }

  static void likePosts({String? postId, required UserModel userModel}) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel.uId)
        .set({'Like': true});
  }

  static void commentPost(
      {String? postId, required String comment, required UserModel userModel}) {
    CommentModel commentModel = CommentModel(
        name: userModel.name,
        dateTime: DateTime.now().toString(),
        image: userModel.image,
        commentData: comment,
        uId: userModel.uId);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(
          commentModel.toMap(),
        );
  }

  static Future<List<CommentModel>> getComments(
      {required String? postId}) async {
    List<CommentModel>? commentModel = [];
    var value = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();

    for (var element in value.docs) {
      commentModel.add(CommentModel.fromJson(element.data()));
    }
    return commentModel;
  }

  static List<UserModel>? chats = [];

  static Future<List<UserModel>> getALLUsers(
      {required UserModel userModel}) async {
    if (chats!.isEmpty) {
      var value = await FirebaseFirestore.instance.collection('users').get();
      for (var element in value.docs) {
        if (userModel.uId == element.data()['uId']) {
          continue;
        }
        chats!.add(UserModel.fromJson(element.data()));
      }
    }
    return chats!;
  }

  static void sendMessage({
    required String dateTime,
    required String text,
    required String recieverId,
    required UserModel userModel,
  }) async {
    ChatModel chatModel = ChatModel(
      text: text,
      dataTime: dateTime,
      recieverId: recieverId,
      senderId: userModel.uId,
    );
    // my chat
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(chatModel.toMap());
    // his chat
    await FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(chatModel.toMap());
  }

  static List<ChatModel>? messages = [];

  static Future<List<ChatModel>> getMessage(
      {required String recieverId, required UserModel userModel}) async {
    // الفويتشر هي داتا جايه كمان شويه لكن الستريم  هي طابور من الفيوتشر الي جايه كمان شويه  يعني هتبقي ريل تايم بمجرد ما تعمل حاجه هيدهلك علطلول
    // الفيوتشر بيجيب الداتا مره واحده كل ما تقوله ويقف  لكن الستريك مجرد ما تقوله هات الداتا مره هيبفضل متابع لها اي تغيير يجيبه تاني
    // بس خد بالك الليسن مجرد ما حاجه جديده تحصل هيلسن من الاول خالص  ف هيديك القديم تاني والجديد وهكئا ف لازم تصفر الليسته
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messages = [];

      for (var element in event.docs) {
        messages!.add(ChatModel.fromJson(element.data()));
      }
    });
    // الستريم مفيهوش سكسس وايرور هي حاجه واحده لانه بيلسن جاب جاب مجابش مجابش
    return messages!;
  }
}
