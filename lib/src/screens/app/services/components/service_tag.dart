import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';

Positioned serviceTag(BuildContext context, AsyncSnapshot<dynamic> snapshot,
    int index, TextTheme style) {
  return Positioned(
    top: 5.h,
    left: MediaQuery.of(context).size.width * 0.18,
    child: snapshot.data.docs![index]['tag'] == 'best'
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
                "Best Seller",
                style: style.bodyText1,
              ),
            ),
          )
        : snapshot.data.docs![index]['tag'] == 'recommended'
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
                    "Recommended",
                    style: style.bodyText1?.copyWith(color: Colors.white),
                  ),
                ),
              )
            : Container(),
  );
}
