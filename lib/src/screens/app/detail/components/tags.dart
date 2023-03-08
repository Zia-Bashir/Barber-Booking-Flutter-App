import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';

Row tags(AsyncSnapshot<dynamic> snapshot, TextTheme style) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      snapshot.data.docs![0]['tag'] == 'best'
          ? Container(
              padding: EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 10.w,
              ),
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
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
      snapshot.data.docs![0]['tag'] == 'recommended'
          ? Container(
              padding: EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 10.w,
              ),
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.darkColor,
              ),
              child: Center(
                child: Text(
                  "Recommended",
                  style: style.bodyText1?.copyWith(color: Colors.white),
                ),
              ),
            )
          : Container(),
      snapshot.data.docs![0]['discount'] != null
          ? Container(
              padding: EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 10.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.darkColor,
              ),
              child: Center(
                child: Text(
                  '${snapshot.data.docs![0]['discount'].toString()}% OFF',
                  style: style.bodyText2,
                ),
              ),
            )
          : Container(),
    ],
  );
}
