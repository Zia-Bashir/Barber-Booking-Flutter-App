import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:the_barber/src/common/utils/utils.dart';

Column titleAnimation(AsyncSnapshot<dynamic> snapshot, TextTheme style) {
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
            snapshot.data.docs![0]['title'],
            style: style.headline3?.copyWith(color: AppColors.mainColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.h,
            ),
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
