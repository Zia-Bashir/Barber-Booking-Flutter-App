import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/utils/app_images.dart';
import 'package:the_barber/src/screens/splash/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //var style = Theme.of(context).textTheme;
    controller.startAnimation();
    return Scaffold(
      backgroundColor: AppColors.secondryColor,
      body: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
              curve: Curves.easeOutQuart,
              duration: const Duration(milliseconds: 1000),
              top: controller.state.animate.value ? 250.h : 100.h,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: controller.state.animate.value ? 1 : 0,
                duration: const Duration(milliseconds: 800),
                child: SvgPicture.asset(barberLogoTop, height: 200.w),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeInOutBack,
              left: 0,
              right: 0,
              bottom: controller.state.animate.value ? 220.h : 150.h,
              child: AnimatedOpacity(
                opacity: controller.state.animate.value ? 1 : 0,
                duration: const Duration(milliseconds: 1200),
                child: SvgPicture.asset(barberLogoBottom, height: 80.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
