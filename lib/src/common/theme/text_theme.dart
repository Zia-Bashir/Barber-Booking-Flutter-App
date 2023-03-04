import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class AppTextTheme {
  //* -- Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.archivo(
        fontSize: 37.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.mainColor),
    headline2: GoogleFonts.archivo(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.mainColor),
    headline3: GoogleFonts.archivo(
      fontSize: 21.sp,
      fontWeight: FontWeight.w600,
    ),
    headline4: GoogleFonts.archivo(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    ),
    headline5: GoogleFonts.archivo(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    ),
    headline6: GoogleFonts.archivo(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: GoogleFonts.archivo(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    ),
    subtitle2: GoogleFonts.archivo(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: GoogleFonts.archivo(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.mainColor),
    bodyText2: GoogleFonts.archivo(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.mainColor),
    button: GoogleFonts.archivo(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    caption: GoogleFonts.archivo(
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
    overline: GoogleFonts.archivo(
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
  );
  //* -- Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.poppins(
        fontSize: 37.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.mainColor),
    headline2: GoogleFonts.poppins(
        fontSize: 21.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.mainColor),
    headline3: GoogleFonts.mulish(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline4: GoogleFonts.mulish(fontSize: 20.sp, fontWeight: FontWeight.w600),
    headline5: GoogleFonts.mulish(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    ),
    headline6: GoogleFonts.mulish(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    ),
    subtitle2: GoogleFonts.mulish(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: GoogleFonts.mulish(
      fontSize: 17.sp,
      fontWeight: FontWeight.w800,
    ),
    bodyText2: GoogleFonts.mulish(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.mainColor),
    button: GoogleFonts.mulish(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    caption: GoogleFonts.mulish(
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
    overline: GoogleFonts.mulish(
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
  );
}
