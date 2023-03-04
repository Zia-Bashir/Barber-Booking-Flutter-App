import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:the_barber/src/common/utils/utils.dart';

class TaglLine extends StatelessWidget {
  const TaglLine({
    Key? key,
    required this.size,
    required this.style,
  }) : super(key: key);

  final double size;
  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //= ------------------ Animation 2.1 ------------------
        Column(
          children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(seconds: 1),
              childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    delay: const Duration(seconds: 1),
                    child: FadeInAnimation(
                      duration: const Duration(seconds: 2),
                      child: widget,
                    ),
                  ),
              children: [
                smallDivider(),

                //= ------------------ Animation 2.1.1 ------------------
                Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 1000),
                    delay: const Duration(seconds: 2),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: -50.0,
                      delay: const Duration(seconds: 1),
                      child: FadeInAnimation(
                        duration: const Duration(seconds: 2),
                        child: widget,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              tAuthRichText,
                              style: style.headline3
                                  ?.copyWith(color: AppColors.mainColor),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(tAuthTagLine, style: style.bodyText1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                smallDivider(),
              ]),
        ),
      ],
    );
  }
  //* ------------------ Divider ------------------

  Padding smallDivider() {
    return Padding(
      padding: EdgeInsets.only(
        right: size * 0.45,
        left: size * 0.45,
      ),
      child: const Divider(
        color: AppColors.darkColor,
        thickness: 3,
      ),
    );
  }
}
