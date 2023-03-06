import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';

Row serviceDetails(
    AsyncSnapshot<dynamic> snapshot, int index, TextTheme style) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      //* ------------------ Price / Title / Description ------------------

      Row(
        children: [
          //* ------------------ Comparasion isDiscount ==null ------------------

          snapshot.data.docs![index]['discount'] == null
              ? Text(
                  "\$ ${snapshot.data.docs![index]['price'].toString()}",
                  style:
                      style.subtitle1?.copyWith(color: AppColors.secondryColor),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //* ------------------ Discount Price ------------------

                      Text(
                        "\$ ${snapshot.data.docs![index]['price'].toString()}",
                        style: style.caption
                            ?.copyWith(decoration: TextDecoration.lineThrough),
                      ),
                      Text(
                        "\$ ${snapshot.data.docs![index]['discountedPrice'].toString()}",
                        style: style.subtitle1
                            ?.copyWith(color: AppColors.secondryColor),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 170.w,
                  child: Text(
                    snapshot.data.docs![index]['title'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style.subtitle1
                        ?.copyWith(color: AppColors.secondryColor),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: 180.w,
                  child: Text(
                    snapshot.data.docs![index]['description'].toString(),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.fade,
                    style: style.caption,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_bag,
            color: AppColors.secondryColor,
          ))
    ],
  );
}
