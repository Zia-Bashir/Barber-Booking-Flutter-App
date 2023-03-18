import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/screens/app/home/components/components.dart';
import 'package:the_barber/src/screens/app/home/index.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.controller, required this.style});
  final HomeController controller;
  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.secondryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //* ------------------ Picture Avatar ------------------

              PictureAvatar(
                controller: controller,
              ),

              //* ------------------ Welcome Text and Search Container ------------------

              TextWithSearchContainer(style: style),

              //* ------------------ Services ------------------

              ServicesGridBuilder(style: style),
            ],
          ),
        ),
      ),
    );
  }
}
