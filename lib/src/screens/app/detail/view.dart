import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/base/loading_widget.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/widgets/widget.dart';
import 'package:the_barber/src/screens/app/cart/controller.dart';
import 'package:the_barber/src/screens/app/detail/components/components.dart';
import 'package:the_barber/src/screens/app/detail/controller.dart';

class DetailScreen extends GetView<DetailController> {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    var cartController = CartController();
    return Scaffold(
      backgroundColor: AppColors.secondryColor,
      appBar: detailAppBar(context, controller),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        child: StreamBuilder(
          stream: servicesRF
              .where("serviceId", isEqualTo: controller.state.servicesId)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Loading(
                isContainer: false,
              );
            } else {
              return SizedBox(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                titleAnimation(snapshot, style),

                                //* ------------------ Comparasion isDiscount ==null ------------------

                                snapshot.data.docs![0]['discount'] == null
                                    ? Text(
                                        "\$ ${snapshot.data.docs![0]['price'].toString()}",
                                        style: style.headline3?.copyWith(
                                            color: AppColors.mainColor),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            //* ------------------ Discount Price ------------------

                                            Text(
                                              "\$ ${snapshot.data.docs![0]['price'].toString()}",
                                              style: style.subtitle2?.copyWith(
                                                  color: Colors.white,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                            Text(
                                              "\$ ${snapshot.data.docs![0]['discountedPrice'].toString()}",
                                              style: style.headline3?.copyWith(
                                                  color: AppColors.mainColor),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),

                            //* ------------------ Tags if Available ------------------

                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: tags(snapshot, style),
                            ),

                            //* ------------------ Service Discription ------------------

                            Text(
                              snapshot.data.docs![0]['description'],
                              maxLines: 20,
                              overflow: TextOverflow.ellipsis,
                              style: style.caption?.copyWith(
                                color: AppColors.mainColor,
                                fontSize: 12.sp,
                                letterSpacing: 1.1,
                                wordSpacing: 1.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            BestSellerServices(style: style)
                          ]),
                    ),

                    //* ------------------ Add to Cart Elevated Button ------------------

                    Positioned(
                      bottom: 20.h,
                      left: 0,
                      right: 0,
                      child: ElevatedButton.icon(
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () async {
                          try {
                            String serviceId =
                                snapshot.data.docs![0]['serviceId'];
                            double servicePrice =
                                snapshot.data.docs![0]['price'];
                            double discountPrice = 0.0;

                            //* ------------------ Check Discount Price ------------------

                            if (snapshot.data.docs![0]['discountedPrice'] !=
                                null) {
                              discountPrice =
                                  snapshot.data.docs![0]['discountedPrice'];
                            }

                            //* ------------------ Check if service already Available  ------------------

                            var querySnapshot = await cartRF
                                .where('serviceId', isEqualTo: serviceId)
                                .get();
                            if (querySnapshot.docs.isNotEmpty) {
                              toastInfo(
                                  msg: "Aldready Available in Cart",
                                  backgroundColor: AppColors.darkColor);
                            } else {
                              cartController.addedToCart(
                                  serviceId: serviceId,
                                  servicePrice: servicePrice,
                                  discountPrice: discountPrice);
                              toastInfo(
                                  msg: "Added to Cart",
                                  backgroundColor: AppColors.darkColor);
                            }
                          } catch (e) {
                            toastInfo(
                                msg: "Error", backgroundColor: Colors.red);
                          }
                        },
                        icon: const Icon(
                          Icons.shopping_bag,
                          color: AppColors.darkColor,
                        ),
                        label: Text(
                          "Add to Cart",
                          style: style.headline4
                              ?.copyWith(color: AppColors.darkColor),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
