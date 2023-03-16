import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/widgets/widget.dart';
import 'package:the_barber/src/screens/app/history/components/components.dart';
import 'package:the_barber/src/screens/app/history/controller.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.secondryColor,
        body: SafeArea(
          child: Column(
            children: [
              //* ------------------  History App Bar ------------------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.darkColor,
                      ),
                    ),

                    //= ------------------ Animated Title ------------------

                    AnimatedTitle(style: style, title: "History"),
                    const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),

              //* ------------------ Tab Bar ------------------

              TabBar(
                unselectedLabelStyle: style.subtitle1,
                unselectedLabelColor: AppColors.mainColor,
                labelColor: AppColors.darkColor,
                labelStyle: style.subtitle1,
                indicator: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(100.r)),
                tabs: const [
                  Tab(
                    text: "Booking",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),

              //* ------------------ Tab Bar View ------------------

              HistoryTabBarView(style: style)
            ],
          ),
        ),
      ),
    );
  }
}
