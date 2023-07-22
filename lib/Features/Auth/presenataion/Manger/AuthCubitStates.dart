abstract class AuthStates {}

// class ChangeAutoValidatorMode extends AuthStates {}
class ChangeVisibilityMode extends AuthStates {}

class LoginInitialState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginFailureState extends AuthStates {
  final String error;

  LoginFailureState(this.error);
}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterFailureState extends AuthStates {
  final String error;

  RegisterFailureState(this.error);
}

class CreateUserSuccessState extends AuthStates {}

class CreateUserFailureState extends AuthStates {
  final String error;

  CreateUserFailureState(this.error);
}
