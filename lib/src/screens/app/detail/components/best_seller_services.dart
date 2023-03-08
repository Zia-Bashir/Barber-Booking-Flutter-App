import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/utils/app_sizes.dart';
import 'package:the_barber/src/common/widgets/animated_title_with_bar_widget.dart';

class BestSellerServices extends StatelessWidget {
  const BestSellerServices({
    Key? key,
    required this.style,
  }) : super(key: key);

  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* ------------------ Animated Title ------------------

        const AnimatedTitleWithBarWidget(text: "Best Sellers"),

        //* ------------------ Stream Builder ------------------

        StreamBuilder(
          //= ------------------ Stream ------------------

          stream: servicesRF.where("tag", isEqualTo: 'best').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              );
            } else {
              return SizedBox(
                width: screenWidth,
                height: 140.h,

                //= ------------------ Animation to List ------------------

                child: AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.docs!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            //* ------------------ Child ------------------

                            child: Container(
                              margin: EdgeInsets.only(right: 10.w),
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 10.w,
                              ),
                              height: 140.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "\$ ${snapshot.data.docs![index]['price']}",
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: style.headline3?.copyWith(
                                              color: AppColors.secondryColor),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          snapshot.data.docs![index]['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: style.caption,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 1.h,
                                    left: 1.w,
                                    child: snapshot.data.docs![index]['tag'] ==
                                            'best'
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 5.h,
                                              horizontal: 10.w,
                                            ),
                                            margin:
                                                EdgeInsets.only(right: 10.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              color: AppColors.darkColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Best Seller",
                                                style: style.bodyText1,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 2.h,
                                      child: GestureDetector(
                                        //TODO Add gesture
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.shopping_bag,
                                          color: AppColors.darkColor,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
