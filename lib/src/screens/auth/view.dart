import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:the_barber/src/common/utils/utils.dart';
import 'package:the_barber/src/common/widgets/my_elevated_button_widget.dart';
import 'package:the_barber/src/screens/auth/components/components.dart';

import 'package:the_barber/src/screens/auth/controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.secondryColor,
      body: SizedBox(
        width: screenWidth,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //= ------------------ Animation 1 ------------------
              Column(
                children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 1000),
                    delay: const Duration(seconds: 3),
                    childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: -50.0,
                          delay: const Duration(seconds: 3),
                          child: FadeInAnimation(
                            duration: const Duration(seconds: 2),
                            child: widget,
                          ),
                        ),
                    children: [
                      //* ------------------ Logo ------------------
                      const AppLogo(),
                    ]),
              ),

              //// - ====================================================================== -

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //= ------------------ Animation 2 ------------------
                  Column(
                    children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 1000),
                        delay: const Duration(seconds: 2),
                        childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 50.0,
                              delay: const Duration(seconds: 2),
                              child: FadeInAnimation(
                                duration: const Duration(seconds: 2),
                                child: widget,
                              ),
                            ),
                        children: [
                          //* ------------------ TagLine ------------------

                          TaglLine(size: size, style: style),

                          //* ------------------ Continue with Goolge ------------------
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 50.h),
                            child: MyElevatedButtonWidget(
                                text: tGoole,
                                ontap: () {
                                  controller.onPressed();
                                }),
                          ),
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
