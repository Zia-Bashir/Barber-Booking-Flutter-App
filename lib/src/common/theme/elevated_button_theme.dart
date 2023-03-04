import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/utils.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  //* -- Light Elevated Button Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      side: const BorderSide(color: AppColors.mainColor),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      backgroundColor: AppColors.mainColor,
    ),
  );

  //* -- Dark Elevated Button Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      side: const BorderSide(
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      backgroundColor: Colors.white,
    ),
  );
}
