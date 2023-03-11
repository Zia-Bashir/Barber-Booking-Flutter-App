import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/utils/utils.dart';
import 'package:the_barber/src/screens/app/cart/controller.dart';

ListView cartListBuilder(AsyncSnapshot<dynamic> snapshot, TextTheme style,
    CartController controller) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(),
    itemCount: snapshot.data.docs!.length,
    itemBuilder: (BuildContext context, int index) {
      DocumentSnapshot cartDocument = snapshot.data!.docs[index];

      String docId = cartDocument['docId'];

      //* ------------------ Stream Builder 2 ------------------

      return StreamBuilder(
        //= ------------------ Services Stream ------------------

        stream: servicesRF.doc(docId).snapshots(),

        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(
              color: AppColors.mainColor,
            );
          } else {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 10.w,
              ),
              margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 5.h),
              height: 80,
              width: screenWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.mainColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      //* ------------------ Comparasion isDiscount ==null ------------------

                      snapshot.data['discount'] == null
                          ? Text(
                              "\$ ${snapshot.data['price'].toString()}",
                              style: style.subtitle1
                                  ?.copyWith(color: AppColors.secondryColor),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //* ------------------ Discount Price ------------------

                                  Text(
                                    "\$ ${snapshot.data['price'].toString()}",
                                    style: style.caption?.copyWith(
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    "\$ ${snapshot.data['discountedPrice'].toString()}",
                                    style: style.subtitle1?.copyWith(
                                        color: AppColors.secondryColor),
                                  ),
                                ],
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: SizedBox(
                          width: 170.w,
                          child: Text(
                            snapshot.data['title'].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: style.subtitle1
                                ?.copyWith(color: AppColors.secondryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        controller.removeFromCart(docId: docId);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: AppColors.darkColor,
                      ))
                ],
              ),
            );
          }
        },
      );
    },
  );
}
