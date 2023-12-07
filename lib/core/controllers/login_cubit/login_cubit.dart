import 'package:e_commerce_app/core/controllers/login_cubit/login_states.dart';
import 'package:e_commerce_app/core/network/constants.dart';
import 'package:e_commerce_app/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitStates());

  static LoginCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void userLogin({required email, required password}) {
    emit(LoginLoadingStates());
    DioHelperStore.postData(url: ApiConstants.registerApi, data: {
      "email": email,
      "password": password,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel!.user!.name!);
      emit(LoginSuccessStates(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorStates());
    });
  }
}
