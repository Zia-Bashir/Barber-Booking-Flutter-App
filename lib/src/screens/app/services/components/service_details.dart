import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/routes/names.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/widgets/toast.dart';
import 'package:the_barber/src/screens/app/cart/index.dart';
import 'package:the_barber/src/screens/app/services/controller.dart';

Row serviceDetails(
    AsyncSnapshot<dynamic> snapshot, int index, TextTheme style) {
  var serviceController = ServicesController();
  var cartController = CartController();

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      //* ------------------ Price / Title / Description ------------------

      //= ------------------ OnTap <Navigate to Details Screen> ------------------

      GestureDetector(
        onTap: () async {
          serviceController.state.id =
              await snapshot.data.docs![index]['serviceId'];
          String serviceTitle = snapshot.data.docs![index]['title'];

          Get.toNamed(AppRoutes.DETAIL, parameters: {
            'id': serviceController.state.id.toString(),
            'title': serviceTitle,
          });
        },
        child: SizedBox(
          child: Row(
            children: [
              //* ------------------ Comparasion isDiscount ==null ------------------

              snapshot.data.docs![index]['discount'] == null
                  ? Text(
                      "\$ ${snapshot.data.docs![index]['price'].toString()}",
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
                            "\$ ${snapshot.data.docs![index]['price'].toString()}",
                            style: style.caption?.copyWith(
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            "\$ ${snapshot.data.docs![index]['discountedPrice'].toString()}",
                            style: style.subtitle1
                                ?.copyWith(color: AppColors.secondryColor),
                          ),
                        ],
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 170.w,
                      child: Text(
                        snapshot.data.docs![index]['title'].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: style.subtitle1
                            ?.copyWith(color: AppColors.secondryColor),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: 180.w,
                      child: Text(
                        snapshot.data.docs![index]['description'].toString(),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.fade,
                        style: style.caption,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //* ------------------ Add to Cart ------------------

      IconButton(
        onPressed: () async {
          try {
            String docId = snapshot.data!.docs[index].id;

            String serviceId = snapshot.data.docs![index]['serviceId'];
            double servicePrice = snapshot.data.docs![index]['price'];
            double discountPrice = 0.0;

            //* ------------------ Check Discount Price ------------------

            if (snapshot.data.docs![index]['discountedPrice'] != null) {
              discountPrice = snapshot.data.docs![index]['discountedPrice'];
            }

            //* ------------------ Check if service already Available  ------------------

            var querySnapshot =
                await cartRF.where('serviceId', isEqualTo: serviceId).get();
            if (querySnapshot.docs.isNotEmpty) {
              toastInfo(
                  msg: "Aldready Available in Cart",
                  backgroundColor: AppColors.darkColor);
            } else {
              cartController.addedToCart(
                  serviceId: serviceId,
                  docId: docId,
                  servicePrice: servicePrice,
                  discountPrice: discountPrice);
              toastInfo(
                  msg: "Added to Cart", backgroundColor: AppColors.darkColor);
            }
          } catch (e) {
            toastInfo(msg: "Error", backgroundColor: Colors.red);
          }
        },
        icon: const Icon(
          Icons.shopping_bag,
          color: AppColors.secondryColor,
        ),
      ),
    ],
  );
}
