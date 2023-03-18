import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/src/common/entities/entities.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/screens/app/home/components/components.dart';
import 'package:the_barber/src/screens/app/home/controller.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key, required this.controller, required this.style});
  final HomeController controller;
  final TextTheme style;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                controller.toggleDrawer();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.mainColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      PictureAvatar(controller: controller),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 190.w,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: menuModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: menuModel[index].onTap,
                                    splashColor: AppColors.mainColor,
                                    child: Container(
                                      width: 180.w,
                                      height: 50.h,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            menuModel[index].icon,
                                            color: AppColors.mainColor,
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            menuModel[index].title!,
                                            style: style.subtitle1?.copyWith(
                                                color: AppColors.mainColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 180.w,
                                  height: 1.h,
                                  margin: EdgeInsets.only(left: 10.w),
                                  color: AppColors.secondryColor,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 20.w, bottom: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Version : ",
                    style:
                        style.subtitle2?.copyWith(color: AppColors.mainColor),
                  ),
                  Text(
                    '0.0.1',
                    style: style.caption?.copyWith(color: AppColors.mainColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
