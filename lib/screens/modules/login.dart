import 'package:e_commerce_app/core/controllers/login_cubit/login_cubit.dart';
import 'package:e_commerce_app/core/controllers/login_cubit/login_states.dart';
import 'package:e_commerce_app/core/managers/nav.dart';
import 'package:e_commerce_app/core/managers/values.dart';
import 'package:e_commerce_app/core/network/local/cache_helper.dart';
import 'package:e_commerce_app/screens/widgets/botton.dart';
import 'package:e_commerce_app/screens/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(listener: (context, states) {
      if (states is LoginSuccessStates) {
        if (states.userModel.status == "success") {
          print(states.userModel.message);
          print(states.userModel.user!.token);
          CacheHelper.saveData(
                  key: 'userId', value: states.userModel.user!.nationalId)
              .then((value) {
            nationalId = states.userModel.user!.nationalId;
          });
          CacheHelper.saveData(
            key: 'token',
            value: states.userModel.user!.token,
          ).then((value) {
            token = states.userModel.user!.token!;
            navigateAndFinishThisScreen(
              context,
              LoginScreen(),
            );
          });
        } else {
          print(states.userModel.message);
        }
      }
    }, builder: (context, states) {
      var cubit = LoginCubit.get(context);

      return Scaffold(
        appBar: AppBar(
          title: Text('Login Screen'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                DefaultFieldForm(
                  labelStyle: TextStyle(color: Colors.black),
                  controller: emailController,
                  keyboard: TextInputType.emailAddress,
                  valid: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter your Email';
                    }
                    return null;
                  },
                  label: 'Email Address',
                  prefix: Icons.email,
                  hint: 'Email Address',
                  hintStyle: const TextStyle(color: Colors.grey),
                  show: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                DefaultFieldForm(
                  labelStyle: TextStyle(color: Colors.black),
                  controller: passwordController,
                  keyboard: TextInputType.visiblePassword,
                  valid: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                  label: 'Password',
                  prefix: Icons.password,
                  hint: 'Password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  show: false,
                ),
                SizedBox(
                  height: 10,
                ),
                DefaultButton(
                    backgroundColor: Colors.black,
                    borderColor: Colors.transparent,
                    buttonWidget: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                    function: () {
                      if (formKey.currentState!.validate()) {
                        cubit.userLogin(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
