import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:the_barber/src/common/utils/utils.dart';

class AnimatedCartTitle extends StatelessWidget {
  const AnimatedCartTitle({
    Key? key,
    required this.style,
  }) : super(key: key);

  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(seconds: 1),
          childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: -50.0,
                delay: const Duration(seconds: 1),
                child: FadeInAnimation(
                  duration: const Duration(seconds: 1),
                  child: widget,
                ),
              ),
          children: [
            //* ------------------ Cart Text ------------------
            Text(
              "Cart",
              style: style.headline3?.copyWith(color: AppColors.mainColor),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5.h,
              ),
              child: Container(
                width: 30.w,
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
