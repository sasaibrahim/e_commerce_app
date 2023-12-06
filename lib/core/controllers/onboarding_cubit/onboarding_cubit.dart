import 'package:e_commerce_app/core/controllers/onboarding_cubit/states.dart';
import 'package:e_commerce_app/core/managers/nav.dart';
import 'package:e_commerce_app/core/network/local/cache_helper.dart';
import 'package:e_commerce_app/screens/modules/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCubit extends Cubit<OnboardingStates> {
  OnBoardingCubit() : super(OnboardindInitStates());

  static OnBoardingCubit get(context) => BlocProvider.of(context);
  bool isPageLast = false;
  int screenIndex = 0;

  void pageLast(index) {
    isPageLast = true;
    screenIndex = index;
    emit(PageLast());
  }

  void pageNotLast(index) {
    isPageLast = false;
    screenIndex = index;
    emit(NotPageLast());
  }

  void submit(context) {
    CacheHelper.saveData(key: 'Boarding', value: true)
        .then((value) => navigateToNextScreen(context, const LoginScreen()));
  }
}
