import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_barber/src/common/utils/utils.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 70.h,
        ),
        SvgPicture.asset(barberLogoTop, height: 200.w),
        SizedBox(
          height: 30.h,
        ),
        SvgPicture.asset(barberLogoBottom, height: 80.w),
      ],
    );
  }
}
