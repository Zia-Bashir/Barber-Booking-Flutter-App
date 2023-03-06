import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:the_barber/src/common/base/loading_widget.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/utils/app_sizes.dart';
import 'package:the_barber/src/screens/app/services/components/components.dart';
import 'package:the_barber/src/screens/app/services/index.dart';

class ServicesListStream extends StatelessWidget {
  const ServicesListStream({super.key, required this.controller});

  final ServicesController controller;

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return StreamBuilder(
      //= ------------------ Stream ------------------

      stream: servicesRF
          .where('categoryName', isEqualTo: controller.state.tag)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Loading(),
              ],
            ),
          );
        } else {
          //= ------------------ Animation ------------------

          return AnimationLimiter(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.docs!.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    delay: const Duration(milliseconds: 100),
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      delay: const Duration(milliseconds: 100),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        width: screenWidth,
                        child: servicesListBuilder(
                            snapshot, index, style, context),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  //= ------------------ Service List Builder ------------------

  Container servicesListBuilder(AsyncSnapshot<dynamic> snapshot, int index,
      TextTheme style, BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.mainColor),
      child: Stack(
        children: [
          //* ------------------ Services Price and Information ------------------

          serviceDetails(snapshot, index, style),

          //* ------------------ Tag if it have ------------------

          serviceTag(context, snapshot, index, style),

          //* ------------------ Discount % Tag if have ------------------

          discountTag(snapshot, index, style),
        ],
      ),
    );
  }
}
