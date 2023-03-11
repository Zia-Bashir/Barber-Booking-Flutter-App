import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/utils/utils.dart';
import 'package:the_barber/src/common/widgets/mytext_widget.dart';
import 'package:the_barber/src/screens/app/cart/controller.dart';

class BookYourAppointment extends StatelessWidget {
  const BookYourAppointment({
    Key? key,
    required this.controller,
    required this.style,
  }) : super(key: key);

  final CartController controller;
  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: screenWidth,
      decoration: BoxDecoration(
        color: AppColors.darkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      "\$ ${controller.state.totalAmount.value.toStringAsFixed(2)}",
                      style:
                          style.subtitle2?.copyWith(color: AppColors.mainColor),
                    ),
                  ),
                  Text(
                    "------->",
                    style: style.subtitle2?.copyWith(
                        color: Colors.white,
                        decoration: TextDecoration.lineThrough),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          "\$ ${controller.state.totalDiscount.value.toStringAsFixed(2)}",
                          style: style.caption?.copyWith(
                              color: Colors.white,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Text(
                        "Discount",
                        style: style.caption?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "------->",
                    style: style.subtitle2?.copyWith(
                        color: Colors.white,
                        decoration: TextDecoration.lineThrough),
                  ),
                  Obx(
                    () => Text(
                      "\$ ${controller.state.priceAfterDiscount.value.toStringAsFixed(2)}",
                      style:
                          style.headline5?.copyWith(color: AppColors.mainColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.date_range_rounded,
                    color: AppColors.secondryColor,
                  ),
                  style: Theme.of(context).elevatedButtonTheme.style,
                  label: MyTextWidget(
                    title: "Book your Appointment",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: AppColors.secondryColor),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
