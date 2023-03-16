import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/utils/app_images.dart';

class PictureAvatar extends StatelessWidget {
  const PictureAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //= ------------------ Animation ------------------
    return Column(
      children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 1000),
          delay: const Duration(seconds: 2),
          childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: -50.0,
                delay: const Duration(seconds: 2),
                child: FadeInAnimation(
                  duration: const Duration(seconds: 2),
                  child: widget,
                ),
              ),
          children: [
            //* ------------------ Picture Avatar ------------------
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Container(
                alignment: Alignment.center,
                height: 70.w,
                width: 70.w,
                child: StreamBuilder(
                  stream: userRF
                      .where("email", isEqualTo: authCurrentUserMail)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: 70.w,
                        width: 70.w,
                        decoration: const BoxDecoration(
                          color: AppColors.mainColor,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(noImage), fit: BoxFit.cover),
                        ),
                      );
                    } else {
                      return Container(
                        height: 70.w,
                        width: 70.w,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            shape: BoxShape.circle,
                            image: snapshot.data.docs![0]['photourl'] == ""
                                ? const DecorationImage(
                                    image: AssetImage(noImage),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data.docs![0]['photourl']),
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
            ),
          ]),
    );
  }
}
