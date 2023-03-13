import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/base/loading_widget.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/utils/utils.dart';
import 'package:the_barber/src/common/widgets/mytext_widget.dart';
import 'package:the_barber/src/common/widgets/toast.dart';
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
      height: 200.h,
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          "\$ ${controller.state.totalAmountWithOutDiscount.value.toStringAsFixed(2)}",
                          style: style.caption?.copyWith(
                              color: controller.state.totalAmountWithOutDiscount
                                          .value !=
                                      controller.state.totalAmount.value
                                  ? Colors.white
                                  : Colors.transparent,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Obx(
                        () => Text(
                          "\$ ${controller.state.totalAmount.value.toStringAsFixed(2)}",
                          style: style.headline4
                              ?.copyWith(color: AppColors.mainColor),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "------->",
                    style: style.subtitle2?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Total Price",
                    style: style.headline6?.copyWith(
                      color: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      controller.state.slectedTime.value = '';
                      controller.selectDate(context, style);
                    },
                    child: Obx(
                      () => Text(
                        controller.state.formattedDate.value != ''
                            ? controller.state.formattedDate.toString()
                            : "Select Date",
                        style: style.headline6?.copyWith(
                            color: AppColors.mainColor,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (controller.state.formattedDate.value == '') {
                        toastInfo(
                          msg: "Please select date first",
                          backgroundColor: AppColors.darkColor,
                        );
                      } else {
                        controller.selectTime(context);
                        String date = controller.state.formattedDate.value;

                        //* ------------------ Show Time Dialog ------------------

                        showTimeDialog(context, date);
                      }
                    },
                    child: Obx(
                      () => Text(
                        controller.state.slectedTime.value != ''
                            ? controller.state.slectedTime.toString()
                            : "Select Time",
                        style: style.headline6?.copyWith(
                            color: AppColors.mainColor,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),

          //* ------------------ Book Your Appointment Button ------------------

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.showOverlay(
                        loadingWidget: const Loading(),
                        asyncFunction: () {
                          return controller.bookappointment();
                        });
                  },
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

  //// - ====================================================================== -

  //* ------------------ Show Time Dialog ------------------

  Future<dynamic> showTimeDialog(BuildContext context, String date) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: AppColors.secondryColor,
        alignment: Alignment.center,
        child: Container(
          height: 350.h,
          width: 400.w,
          padding: EdgeInsets.symmetric(
            vertical: 10.w,
            horizontal: 20.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondryColor,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: AppColors.darkColor.withOpacity(0.2),
                  blurRadius: 5.r),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: Text(
                        "Select Time",
                        style: style.headline4?.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    //* ------------------ Appointment Stream Builder ------------------

                    Obx(
                      () => controller.state.isDocAvailable.value == false
                          ? const CircularProgressIndicator(
                              color: AppColors.mainColor,
                            )
                          : StreamBuilder(
                              stream: appointmentRF
                                  .doc(date)
                                  .collection('time')
                                  .where('isBooked', isEqualTo: false)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator(
                                    color: AppColors.mainColor,
                                  );
                                } else {
                                  if (snapshot.data.docs.length == 0) {
                                    return Expanded(
                                      child: Center(
                                        child: Text(
                                          "No Slot Available",
                                          style: style.headline6?.copyWith(
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Available Slot",
                                              style: style.headline6?.copyWith(
                                                color: AppColors.mainColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        SizedBox(
                                          height: 220.h,
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    childAspectRatio: 2.5,
                                                    crossAxisSpacing: 20,
                                                    mainAxisSpacing: 20),
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              //* ------------------ Time Slot Grid ------------------

                                              return GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .selectedTimeSlot(index);

                                                  controller
                                                          .state
                                                          .selectedTimeDocId
                                                          .value =
                                                      snapshot
                                                          .data
                                                          .docs[controller
                                                              .state
                                                              .selectedTimeSlot
                                                              .value]
                                                          .id;
                                                  controller.state.slectedTime
                                                          .value =
                                                      snapshot.data.docs[
                                                          controller
                                                              .state
                                                              .selectedTimeSlot
                                                              .value]['time'];
                                                },
                                                child: Obx(
                                                  () => Container(
                                                    decoration: BoxDecoration(
                                                      color: controller
                                                                  .state
                                                                  .selectedTimeSlot
                                                                  .value ==
                                                              index
                                                          ? AppColors.mainColor
                                                          : AppColors.darkColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        snapshot.data
                                                                .docs![index]
                                                            ['time'],
                                                        style: style.subtitle2
                                                            ?.copyWith(
                                                          color: controller
                                                                      .state
                                                                      .selectedTimeSlot
                                                                      .value ==
                                                                  index
                                                              ? AppColors
                                                                  .darkColor
                                                              : AppColors
                                                                  .mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }
                              },
                            ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style:
                        style.subtitle1?.copyWith(color: AppColors.mainColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
