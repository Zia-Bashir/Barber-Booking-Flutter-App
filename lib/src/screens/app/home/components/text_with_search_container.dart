import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/routes/names.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/utils/app_sizes.dart';

class TextWithSearchContainer extends StatelessWidget {
  const TextWithSearchContainer({
    Key? key,
    required this.style,
  }) : super(key: key);

  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //= ------------------ Animation ------------------
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(seconds: 1),
              childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: -50.0,
                    delay: const Duration(seconds: 1),
                    child: FadeInAnimation(
                      duration: const Duration(seconds: 2),
                      child: widget,
                    ),
                  ),
              children: [
                //* ------------------ Welcome Text ------------------
                Text(
                  "Welcome,",
                  style: style.headline2?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w200),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: StreamBuilder(
                    stream: userRF
                        .where("email", isEqualTo: authCurrentUserMail)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          "User",
                          style: style.headline1,
                        );
                      } else {
                        return snapshot.data.docs![0]['name'] == ''
                            ? Text(
                                "User",
                                style: style.headline1,
                              )
                            : Text(
                                snapshot.data.docs![0]['name'],
                                style: style.headline1,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                      }
                    },
                  ),
                ),
              ]),
        ),

        //= ------------------ Animation 3 ------------------

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(seconds: 2),
              childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    delay: const Duration(seconds: 1),
                    child: FadeInAnimation(
                      duration: const Duration(seconds: 2),
                      child: widget,
                    ),
                  ),
              children: [
                //* ------------------ Search Bar Container ------------------
                Hero(
                  tag: "search",
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.SEARCH);
                    },
                    child: Container(
                      width: screenWidth,
                      height: 50.h,
                      margin: EdgeInsets.only(top: 20.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: Colors.white),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 25.w),
                              child: Text(
                                "Search Services",
                                style: style.subtitle1,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25.r),
                              child: Container(
                                width: 80.w,
                                height: 50.h,
                                color: AppColors.darkColor,
                                child: Center(
                                  child: Icon(
                                    Icons.search,
                                    color: AppColors.mainColor,
                                    size: 30.r,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ],
    );
  }
}
