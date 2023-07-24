abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

/////////////////////
////////////////////
class ChangeVisibilityMode extends AuthStates {}

class ChangeRemeberLoginState extends AuthStates {}

///////////////////
/////////////////
class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginFailureState extends AuthStates {
  final String error;

  LoginFailureState(this.error);
}

///////////////////////////////
/////////////////////////
class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterFailureState extends AuthStates {
  final String error;

  RegisterFailureState(this.error);
}

//////////////////////////
////////////////////////
class CreateUserLoadingState extends AuthStates {}

class CreateUserSuccessState extends AuthStates {}

class CreateUserFailureState extends AuthStates {
  final String error;

  CreateUserFailureState(this.error);
}

/////////////////
class LoginLoadingGoogleState extends AuthStates {}

class LoginSuccessCreateAcccountGoogleState extends AuthStates {
  final String uId;

  LoginSuccessCreateAcccountGoogleState(this.uId);
}

class LoginFailureGoogleState extends AuthStates {
  final String error;

  LoginFailureGoogleState(this.error);
}

///////////////////////
class LoginLoadingFacebookState extends AuthStates {}

class LoginSuccessFacebookState extends AuthStates {
  final String uId;

  LoginSuccessFacebookState(this.uId);
}

class LogingFailureacebookState extends AuthStates {
  final String error;

  LogingFailureacebookState(this.error);
}
