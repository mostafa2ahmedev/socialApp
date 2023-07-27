import 'PostModel.dart';

class PostData {
  List<PostModel> posts;
  List<String> postsId;
  List<int> likes;

  PostData({required this.posts, required this.postsId, required this.likes});
}
