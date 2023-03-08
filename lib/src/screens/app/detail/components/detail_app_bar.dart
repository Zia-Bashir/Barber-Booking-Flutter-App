import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/utils/utils.dart';
import 'package:the_barber/src/screens/app/detail/controller.dart';

PreferredSize detailAppBar(BuildContext context, DetailController controller) {
  var style = Theme.of(context).textTheme;
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromARGB(255, 208, 149, 67),
      elevation: 5,
      shadowColor: AppColors.mainColor,
      flexibleSpace: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 24.w, left: 24.w),
        decoration: const BoxDecoration(),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_ios_new),
              ),
              Text(
                controller.state.servicesTitle,
                style: style.headline4?.copyWith(color: AppColors.darkColor),
              ),
              const Icon(
                Icons.shopping_bag,
                color: AppColors.secondryColor,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
