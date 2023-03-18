import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/utils/utils.dart';

StreamBuilder<QuerySnapshot<Map<String, dynamic>>> completedStreamBuilder(
    TextTheme style) {
  //= ------------------ Booking Stream Builder ------------------

  return StreamBuilder(
    stream: bookingRF
        .where("mail", isEqualTo: authCurrentUserMail)
        .where("status", isEqualTo: "completed")
        .orderBy("bookingTime", descending: true)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: AppColors.mainColor,
            ),
          ),
        );
      } else {
        if (snapshot.data.docs.length == 0) {
          return Center(
            child: Text(
              "No Booking Completed",
              style: style.headline3,
            ),
          );
        } else {
          //= ------------------ Booking List Builder ------------------

          return ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 120.h,
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 20.w,
                ),
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                width: screenWidth,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //* ------------------ Services List & Date/Time Column ------------------

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //= ------------------ Services List ------------------

                        SizedBox(
                          width: 200.w,
                          height: 70.h,

                          //= ------------------ Services List Builder ------------------

                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                snapshot.data.docs[index]['services'].length,
                            itemBuilder: (BuildContext context, int index2) {
                              return Container(
                                height: 80.h,
                                width: 100.w,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.h,
                                ),
                                margin: EdgeInsets.only(right: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.darkColor,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //* ------------------ Service Price ------------------
                                    snapshot.data.docs[index]['services']
                                                [index2]['Discount'] !=
                                            0
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "\$ ${snapshot.data.docs[index]['services'][index2]['price'].toString()}",
                                                style: style.caption?.copyWith(
                                                    color: Colors.white,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              Text(
                                                "\$ ${snapshot.data.docs[index]['services'][index2]['Discount'].toString()}",
                                                style: style.subtitle1
                                                    ?.copyWith(
                                                        color: AppColors
                                                            .mainColor),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            "\$ ${snapshot.data.docs[index]['services'][index2]['price'].toString()}",
                                            style: style.subtitle1?.copyWith(
                                                color: AppColors.mainColor),
                                          ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    //* ------------------ Service Title ------------------
                                    Text(
                                      snapshot
                                          .data
                                          .docs[index]['services'][index2]
                                              ['title']
                                          .toString(),
                                      style: style.caption?.copyWith(
                                          fontSize: 8.sp,
                                          color: AppColors.mainColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        //= ------------------ Date/Time ------------------

                        SizedBox(
                          width: 200.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date : ",
                                    style: style.subtitle2
                                        ?.copyWith(color: AppColors.darkColor),
                                  ),
                                  Text(
                                    snapshot.data.docs[index]['date'] ?? '',
                                    style: style.caption
                                        ?.copyWith(color: AppColors.darkColor),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Slot : ",
                                    style: style.subtitle2
                                        ?.copyWith(color: AppColors.darkColor),
                                  ),
                                  Text(
                                    snapshot.data.docs[index]['timeSlot'] ?? '',
                                    style: style.caption
                                        ?.copyWith(color: AppColors.darkColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //* ------------------ Price and Booked Column ------------------

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5.w,
                            horizontal: 10.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.secondryColor,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.done,
                                size: 10.r,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Completed",
                                style: style.caption
                                    ?.copyWith(color: AppColors.mainColor),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total Price",
                              style: style.caption
                                  ?.copyWith(color: AppColors.darkColor),
                            ),
                            Text(
                              "\$ ${snapshot.data.docs[index]['price'].toString()}",
                              style: style.headline5
                                  ?.copyWith(color: AppColors.darkColor),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          width: 80.w,
                          child: duTimeLineFormat((snapshot.data.docs[index]
                                          ['bookingTime'] as Timestamp)
                                      .toDate()) ==
                                  "0 m ago"
                              ? Text(
                                  "now",
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: style.caption
                                      ?.copyWith(color: AppColors.darkColor),
                                )
                              : Text(
                                  duTimeLineFormat((snapshot.data.docs[index]
                                          ['bookingTime'] as Timestamp)
                                      .toDate()),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: style.caption
                                      ?.copyWith(color: AppColors.darkColor),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      }
    },
  );
}
