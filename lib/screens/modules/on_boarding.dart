import 'package:e_commerce_app/core/controllers/onboarding_cubit/onboarding_cubit.dart';
import 'package:e_commerce_app/core/controllers/onboarding_cubit/states.dart';
import 'package:e_commerce_app/core/managers/lists.dart';
import 'package:e_commerce_app/screens/widgets/botton.dart';
import 'package:e_commerce_app/screens/widgets/build_onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnboardingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var boardingController = PageController();
        var cubit = OnBoardingCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("OnBoard"),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("pixel",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 40)),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    height: 400,
                    child: PageView.builder(
                      onPageChanged: (index) {
                        if (index == onboard.length - 1) {
                          cubit.pageLast(index);
                        } else {
                          cubit.pageNotLast(index);
                        }
                      },
                      itemBuilder: (context, index) =>
                          buildOnBoardingItem(onboard[index]),
                      controller: boardingController,
                      physics: BouncingScrollPhysics(),
                      itemCount: onboard.length,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                cubit.isPageLast
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DefaultButton(
                            backgroundColor: Colors.black,
                            function: () {
                              cubit.submit(context);
                            },
                            buttonWidget: Text(
                              'GetStarted',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DefaultButton(
                            backgroundColor: Colors.black,
                            function: () {
                              boardingController.nextPage(
                                  duration: Duration(milliseconds: 750),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            },
                            buttonWidget: Text('Next',
                                style: TextStyle(color: Colors.white))),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
