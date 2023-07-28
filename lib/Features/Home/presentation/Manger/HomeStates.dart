abstract class HomeStates {}

class HomeInitailState extends HomeStates {}

class GetUserLoadingState extends HomeStates {}

class GetUserSuccessState extends HomeStates {}

class GetUserFailureState extends HomeStates {
  final String error;

  GetUserFailureState(this.error);
}

class ChangeNavState extends HomeStates {}

class ChangePostState extends HomeStates {}

class ChangeProfileImageSuccesstate extends HomeStates {}

class ChangeProfileImageFailurState extends HomeStates {}

class ChangeCoverImageSuccesstate extends HomeStates {}

class ChangeCoverImageFailurState extends HomeStates {}

class UploadImageLodaingState extends HomeStates {}

class UploadProfileImageSuccesstate extends HomeStates {}

class UploadProfileImageFailurState extends HomeStates {}

class UploadCoverImageSuccesstate extends HomeStates {}

class UploadCoverImageFailurState extends HomeStates {}

class UpdateUserFailurState extends HomeStates {}

class UpdateUserSuccessState extends HomeStates {}

class UpdateUserLoadingState extends HomeStates {}

////////// create post /////////////////
class CreatePostLoadingState extends HomeStates {}

class CreatePostSuccessState extends HomeStates {}

class CreatePostFailureState extends HomeStates {}

/////////  postImage/////////
class ChangePostImageSuccessState extends HomeStates {}

class ChangePostImageFailurState extends HomeStates {}

///////////get post ////////////

class RemovePostImage extends HomeStates {}

class GetPostLoadingState extends HomeStates {}

class GetPostSuccessState extends HomeStates {}

class GetPostFailureState extends HomeStates {
  final String error;

  GetPostFailureState(this.error);
}

/////// likePost////////
class LikePostSuccessState extends HomeStates {}

class LikePostFailureState extends HomeStates {
  final String error;

  LikePostFailureState(this.error);
}

///////////////////// commentpost//////////
class CommentPostSuccessState extends HomeStates {}

class CommentPostFailureState extends HomeStates {
  final String error;

  CommentPostFailureState(this.error);
}

//////////// getcomments///////////
class GetCommentLoadingState extends HomeStates {}

class GetCommentSuccessState extends HomeStates {}

class GetCommentFailureState extends HomeStates {
  final String error;

  GetCommentFailureState(this.error);
}

//// GETALLUSERS////
class GetAllUsersLoadingState extends HomeStates {}

class GetAllUsersSuccessState extends HomeStates {}

class GetAllUsersFailureState extends HomeStates {
  final String error;

  GetAllUsersFailureState(this.error);
}

/////sendMessage///
class SendMessageSuccessState extends HomeStates {}

class SendMessageFailureState extends HomeStates {
  final String error;

  SendMessageFailureState(this.error);
}

class GetMessageLoadingState extends HomeStates {}

class GetMessageSuccessState extends HomeStates {}

class GetMessageFailureState extends HomeStates {
  final String error;

  GetMessageFailureState(this.error);
}
