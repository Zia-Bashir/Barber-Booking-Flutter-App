import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/screens/app/home/components/components.dart';
import 'package:the_barber/src/screens/app/home/index.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.secondryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //* ------------------ Picture Avatar ------------------

              const PictureAvatar(),

              //* ------------------ Welcome Text and Search Container ------------------

              TextWithSearchContainer(style: style),

              //* ------------------ Services ------------------
              //= ------------------ Animation 3 ------------------

              ServicesGridBuilder(style: style),
            ],
          ),
        ),
      ),
    );
  }
}
