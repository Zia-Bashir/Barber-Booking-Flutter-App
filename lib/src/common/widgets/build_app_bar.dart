import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/entities/entities.dart';
import 'package:the_barber/src/common/utils/utils.dart';
import 'package:the_barber/src/screens/app/services/controller.dart';

PreferredSize buildAppBar(BuildContext context, ServicesController controller) {
  var style = Theme.of(context).textTheme;
  return PreferredSize(
    preferredSize: Size.fromHeight(80.h),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //= ------------------ Hero Image ------------------

                  Hero(
                    tag: servicesModel[controller.state.servicesId].tag!,
                    child: SvgPicture.asset(
                        servicesModel[controller.state.servicesId].imgUrl!),
                  ),

                  //* ------------------ Service Title ------------------

                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h, top: 5.h),
                    child: Text(
                      servicesModel[controller.state.servicesId].title!,
                      style:
                          style.subtitle1?.copyWith(color: AppColors.darkColor),
                    ),
                  )
                ],
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
