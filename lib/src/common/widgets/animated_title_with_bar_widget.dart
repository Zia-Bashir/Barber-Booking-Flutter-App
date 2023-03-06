import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';

class AnimatedTitleWithBarWidget extends StatelessWidget {
  const AnimatedTitleWithBarWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    //= ------------------ Animation ------------------
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(seconds: 2),
          childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: -50.0,
                delay: const Duration(seconds: 2),
                child: FadeInAnimation(
                  duration: const Duration(seconds: 1),
                  child: widget,
                ),
              ),
          children: [
            //* ------------------ Services Text ------------------
            Text(
              text,
              style: style.headline2,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
              child: Container(
                width: 50.w,
                height: 3.h,
                decoration: const BoxDecoration(
                  color: AppColors.darkColor,
                ),
              ),
            ),
          ]),
    );
  }
}
