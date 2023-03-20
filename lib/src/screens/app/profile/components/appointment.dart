import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/routes/names.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/utils/my_icons_icons.dart';
import 'package:badges/badges.dart' as badges;

class Appointment extends StatelessWidget {
  const Appointment({super.key, required this.stream, required this.icon});

  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.HISTORY);
      },
      child: SizedBox(
        child: badges.Badge(
          badgeContent: StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Text('0');
              } else {
                return Text(
                  snapshot.data!.docs.length.toString(),
                  style: const TextStyle(
                      color: AppColors.darkColor, fontWeight: FontWeight.bold),
                );
              }
            },
          ),
          badgeAnimation: const badges.BadgeAnimation.rotation(
            animationDuration: Duration(seconds: 1),
            colorChangeAnimationDuration: Duration(seconds: 1),
            loopAnimation: false,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.easeInCubic,
          ),
          badgeStyle: const badges.BadgeStyle(
            shape: badges.BadgeShape.circle,
            badgeColor: AppColors.mainColor,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 10.w,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.darkColor),
            child: const Icon(
              MyIcons.booking,
              color: AppColors.mainColor,
            ),
          ),
        ),
      ),
    );
  }
}
