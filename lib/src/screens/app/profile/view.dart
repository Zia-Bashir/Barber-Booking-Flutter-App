import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/utils/my_icons_icons.dart';
import 'package:the_barber/src/common/widgets/widget.dart';
import 'package:the_barber/src/screens/app/profile/components/components.dart';
import 'package:the_barber/src/screens/app/profile/controller.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/utils/app_images.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.secondryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              //* ------------------ Appbar and UserDetails ------------------

              Column(
                children: [
                  //* ------------------ App Bar ------------------

                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 20.h, bottom: 50.h),
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

                        AnimatedTitle(style: style, title: "Profile"),
                        const Icon(
                          Icons.history,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                  ),

                  //* ------------------ User Detais ------------------

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //* ------------------ Picture Avatar ------------------
                      Container(
                        alignment: Alignment.center,
                        child: StreamBuilder(
                          stream: userRF
                              .where("email", isEqualTo: authCurrentUserMail)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                height: 100.w,
                                width: 100.w,
                                decoration: const BoxDecoration(
                                  color: AppColors.mainColor,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(noImage),
                                      fit: BoxFit.cover),
                                ),
                              );
                            } else {
                              return Container(
                                height: 100.w,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    shape: BoxShape.circle,
                                    image:
                                        snapshot.data.docs![0]['photourl'] == ""
                                            ? const DecorationImage(
                                                image: AssetImage(noImage),
                                                fit: BoxFit.cover)
                                            : DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data.docs![0]['photourl']),
                                                fit: BoxFit.cover),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.mainColor,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 2),
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 5)
                                    ]),
                              );
                            }
                          },
                        ),
                      ),

                      //* ------------------ Name & gmail ------------------

                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.75,
                        margin: EdgeInsets.only(top: 30.h, bottom: 5.h),
                        child: StreamBuilder(
                          stream: userRF
                              .where("email", isEqualTo: authCurrentUserMail)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                "User",
                                style: style.headline1,
                              );
                            } else {
                              return snapshot.data.docs![0]['name'] == ''
                                  ? Text(
                                      "User",
                                      style: style.headline1,
                                    )
                                  : Text(
                                      snapshot.data.docs![0]['name'],
                                      style: style.headline1,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    );
                            }
                          },
                        ),
                      ),
                      Text(
                        authCurrentUserMail.toString(),
                        style: style.subtitle2?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),

              //* ------------------ Total Appoinments ------------------
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Total Appointments",
                    style: style.headline3,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Appointment(
                          stream: bookingRF
                              .where("mail", isEqualTo: authCurrentUserMail)
                              .where("status", isEqualTo: "booked")
                              .orderBy("bookingTime", descending: true)
                              .snapshots(),
                          icon: MyIcons.booking),
                      SizedBox(
                        width: 30.w,
                      ),
                      Appointment(
                          stream: bookingRF
                              .where("mail", isEqualTo: authCurrentUserMail)
                              .where("status", isEqualTo: "completed")
                              .orderBy("bookingTime", descending: true)
                              .snapshots(),
                          icon: MyIcons.appointment),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child:
                    MyElevatedButtonWidget(text: "Edit Profile", ontap: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
