import 'package:e_commerce_app/models/user_model.dart';

abstract class RegisterStates {}

class RegisterInitStates extends RegisterStates {}

class LoadingRegister extends RegisterStates {}

class RegisterSuccessStates extends RegisterStates {
  final UserModel userModel;

  RegisterSuccessStates(this.userModel);
}

class RegisterErrorStates extends RegisterStates {}

class ChooseImage extends RegisterStates {}
