import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';

Positioned discountTag(
    AsyncSnapshot<dynamic> snapshot, int index, TextTheme style) {
  return Positioned(
    bottom: 5.h,
    left: 5.w,
    child: //* ------------------ Discount % ------------------

        snapshot.data.docs![index]['discount'] != null
            ? Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 5.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.darkColor,
                ),
                child: Center(
                  child: Text(
                    '${snapshot.data.docs![index]['discount'].toString()}% OFF',
                    style: style.bodyText2,
                  ),
                ),
              )
            : Container(),
  );
}
