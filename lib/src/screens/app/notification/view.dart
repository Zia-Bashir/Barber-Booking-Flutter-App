import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/utils/app_sizes.dart';
import 'package:the_barber/src/common/utils/date.dart';
import 'package:the_barber/src/common/utils/my_icons_icons.dart';
import 'package:the_barber/src/common/widgets/widget.dart';
import 'package:the_barber/src/screens/app/notification/index.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.secondryColor,
      body: SafeArea(
        child: Column(
          children: [
            //* ------------------  Notification App Bar ------------------
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

                  AnimatedTitle(style: style, title: "Notification"),
                  const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: notificationRF
                    .orderBy("time", descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: SizedBox(
                        width: 30,
                        height: 40,
                        child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        ),
                      ),
                    );
                  } else {
                    if (snapshot.data.docs.length == 0) {
                      return Center(
                        child: Text(
                          "No Notification",
                          style: style.headline3,
                        ),
                      );
                    } else {
                      return AnimationLimiter(
                        child: ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                delay: const Duration(milliseconds: 100),
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  delay: const Duration(milliseconds: 100),
                                  child: SizedBox(
                                    width: screenWidth,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: screenWidth,
                                          height: 70.h,
                                          padding: EdgeInsets.only(
                                              left: 20.w,
                                              top: 10.h,
                                              bottom: 10.h,
                                              right: 10.w),
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 50.w,
                                                      width: 50.w,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: AppColors
                                                                  .mainColor),
                                                      child: Center(
                                                        child: snapshot.data.docs[
                                                                        index][
                                                                    'isBooking'] ==
                                                                false
                                                            ? const Icon(
                                                                MyIcons
                                                                    .announcement,
                                                                color: AppColors
                                                                    .darkColor,
                                                              )
                                                            : const Icon(
                                                                MyIcons.booking,
                                                                color: AppColors
                                                                    .darkColor,
                                                              ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 260.w,
                                                          child: Text(
                                                            snapshot
                                                                .data
                                                                .docs[index]
                                                                    ['title']
                                                                .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: style
                                                                .subtitle1
                                                                ?.copyWith(
                                                                    color: AppColors
                                                                        .mainColor),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        SizedBox(
                                                          width: 250.w,
                                                          child: Text(
                                                            snapshot
                                                                .data
                                                                .docs[index]
                                                                    ['body']
                                                                .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: style.caption
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: 5.h,
                                                right: 10.w,
                                                child: duTimeLineFormat(
                                                            (snapshot.data.docs[
                                                                            index]
                                                                        ['time']
                                                                    as Timestamp)
                                                                .toDate()) ==
                                                        "0 m ago"
                                                    ? Text(
                                                        "now",
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: style.caption
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white),
                                                      )
                                                    : Text(
                                                        duTimeLineFormat(
                                                            (snapshot.data.docs[
                                                                            index]
                                                                        ['time']
                                                                    as Timestamp)
                                                                .toDate()),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: style.caption
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth,
                                          height: 1.h,
                                          color: AppColors.darkColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
