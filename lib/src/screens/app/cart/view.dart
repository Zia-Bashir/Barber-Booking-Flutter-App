import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:the_barber/src/common/base/loading_widget.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/routes/names.dart';
import 'package:the_barber/src/common/utils/utils.dart';
import 'package:the_barber/src/screens/app/cart/components/components.dart';
import 'package:the_barber/src/screens/app/cart/controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.secondryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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

                        AnimatedTitle(style: style, title: "Cart"),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.HISTORY);
                          },
                          child: const Icon(
                            Icons.history,
                            color: AppColors.darkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    //* ------------------ Stream Builder 1 ------------------

                    child: StreamBuilder(
                      //= ------------------ Stream Cart Services ------------------

                      stream: cartRF.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Loading();
                        } else {
                          if (snapshot.data.docs.length == 0) {
                            return Center(
                              child:
                                  Lottie.asset(emptyCartLottie, repeat: true),
                            );
                          } else {
                            return cartListBuilder(snapshot, style, controller);
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: StreamBuilder(
                stream: cartRF.snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    if (snapshot.data.docs.length == 0) {
                      return Container();
                    } else {
                      return BookYourAppointment(
                        controller: controller,
                        style: style,
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
