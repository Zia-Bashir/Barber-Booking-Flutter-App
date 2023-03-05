import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_barber/src/common/entities/entities.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';

class ServicesGridBuilder extends StatelessWidget {
  const ServicesGridBuilder({
    Key? key,
    required this.style,
  }) : super(key: key);

  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
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
                  "Services",
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
        ),

        //= ------------------ Animation ------------------

        AnimationLimiter(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.85,
            ),
            itemCount: servicesModel.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 4,
                child: SlideAnimation(
                  duration: const Duration(seconds: 2),
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    duration: const Duration(seconds: 2),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                        horizontal: 20.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(servicesModel[index].imgUrl!,
                              height: 100.r),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            servicesModel[index].title!,
                            style: style.subtitle1,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
