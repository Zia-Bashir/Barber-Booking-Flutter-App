import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/entities/entities.dart';
import 'package:the_barber/src/common/routes/names.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';

import '../../../../common/widgets/widget.dart';

class ServicesGridBuilder extends StatelessWidget {
  const ServicesGridBuilder({
    Key? key,
    required this.style,
  }) : super(key: key);

  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AnimatedTitleWithBarWidget(text: "Services"),

        //= ------------------ Animation ------------------

        AnimationLimiter(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.85,
            ),
            itemCount: servicesModel.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 500),
                columnCount: 4,
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 1000),
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              var tag = servicesModel[index].tag!;
                              Get.toNamed(AppRoutes.SERVICES, parameters: {
                                'index': index.toString(),
                                'tag': tag,
                              });
                            },
                            splashColor: AppColors.mainColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.h,
                                horizontal: 20.w,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Hero(
                                    tag: servicesModel[index].tag!,
                                    child: SvgPicture.asset(
                                        servicesModel[index].imgUrl!,
                                        height: 100.r),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    servicesModel[index].title!,
                                    style: style.subtitle1,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
