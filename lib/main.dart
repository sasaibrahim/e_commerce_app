import 'package:e_commerce_app/core/controllers/onboarding_cubit/onboarding_cubit.dart';
import 'package:e_commerce_app/core/controllers/register_cubit/register_cubit.dart';
import 'package:e_commerce_app/core/managers/themes.dart';
import 'package:e_commerce_app/core/managers/values.dart';
import 'package:e_commerce_app/core/network/local/cache_helper.dart';
import 'package:e_commerce_app/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app/screens/modules/on_boarding.dart';
import 'package:e_commerce_app/screens/modules/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelperStore.init();
  await CacheHelper.init();

  boarding = CacheHelper.getData(key: 'Boarding');
  token = CacheHelper.getData(key: 'token');
  nationalId = CacheHelper.getData(key: 'userId');
  print(boarding);
  print(token);
  print(nationalId);

  if (boarding) {
    nextScreen = RegisterScreen();
  } else {
    nextScreen = const OnBoardingScreen();
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        home: nextScreen,
      ),
    );
  }
}
