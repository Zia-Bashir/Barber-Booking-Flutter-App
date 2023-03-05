import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/utils/app_images.dart';

class PictureAvatar extends StatelessWidget {
  const PictureAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //= ------------------ Animation ------------------
    return Column(
      children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 1000),
          delay: const Duration(seconds: 2),
          childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: -50.0,
                delay: const Duration(seconds: 2),
                child: FadeInAnimation(
                  duration: const Duration(seconds: 2),
                  child: widget,
                ),
              ),
          children: [
            //* ------------------ Picture Avatar ------------------
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: const CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.mainColor,
                backgroundImage: AssetImage(noImage),
              ),
            ),
          ]),
    );
  }
}
