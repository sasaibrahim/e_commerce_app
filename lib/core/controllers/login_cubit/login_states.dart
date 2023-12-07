import 'package:e_commerce_app/models/user_model.dart';

abstract class LoginStates {}

class LoginInitStates extends LoginStates {}

class LoginLoadingStates extends LoginStates {}

class LoginSuccessStates extends LoginStates {
  UserModel userModel;

  LoginSuccessStates(this.userModel);
}

class LoginErrorStates extends LoginStates {}
