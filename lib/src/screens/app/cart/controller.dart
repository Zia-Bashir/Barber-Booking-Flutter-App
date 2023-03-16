import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_barber/src/common/firebase/fcm_services.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/widgets/widget.dart';
import 'package:the_barber/src/screens/app/cart/index.dart';

import '../../../common/utils/utils.dart';

class CartController extends GetxController {
  final state = CartState();
  CartController();

  @override
  void onInit() {
    getAmountAndDiscount();
    super.onInit();
  }

  //* ------------------ Add to Cart ------------------

  addedToCart(
      {required String serviceId,
      required double servicePrice,
      required String docId,
      required String serviceTitle,
      required double discountPrice}) {
    return cartRF.doc(docId).set({
      "uid": authCurrentUserMail,
      "serviceId": serviceId,
      "title": serviceTitle,
      "price": servicePrice,
      "docId": docId,
      "discountPrice": discountPrice
    });
  }

  //// - ====================================================================== -

  //* ------------------ Remove from Cart ------------------

  removeFromCart({required String docId}) {
    try {
      cartRF.doc(docId).delete();
      getAmountAndDiscount();
      toastInfo(msg: "Removed");
    } catch (e) {
      toastInfo(msg: "Error", backgroundColor: Colors.red);
    }
  }

  //// - ====================================================================== -

  //* ------------------ Updated the Latest Price / Discount of Carted Services ------------------

  updateCartProductPrice() async {
    await cartRF.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var i = 0; i < snapshot.docs.length; i++) {
          String docId = snapshot.docs[i]['docId'];
          servicesRF.doc(docId).get().then((DocumentSnapshot doc) async {
            state.servicesPrice.value = doc['price'];

            //state.discount.value = doc['discountPrice'];

            await cartRF.doc(docId).update({
              "price": state.servicesPrice.value,
              //'discountPrice': state.discount.value,
            });
          });
        }
      }
    });
  }

  //// - ====================================================================== -

  //* ------------------ Get Total Amount and Discount ------------------

  getAmountAndDiscount() {
    getTotalWithDiscount();
    getTotalWithOutDiscount();
  }

  //// - ====================================================================== -

  //* ------------------ Total Amount with Discount of Cart Services  ------------------

  Future<double> getTotalWithDiscount() async {
    QuerySnapshot snapshot = await cartRF.get();
    double totalPrice = 0.0;
    double totalDiscount = 0.0;
    for (var i = 0; i < snapshot.docs.length; i++) {
      double price = snapshot.docs[i]['price'];
      double discount = snapshot.docs[i]['discountPrice'];
      if (discount > 0) {
        totalDiscount = price - discount;
      } else {
        totalDiscount = 0.0;
      }
      totalPrice = totalPrice + (price - totalDiscount);
    }
    state.totalAmount.value = totalPrice;
    return state.totalAmount.value;
  }

  //// - ====================================================================== -

  //* ------------------ Total Amount withOut Discount of Cart Services  ------------------

  Future<double> getTotalWithOutDiscount() async {
    QuerySnapshot snapshot = await cartRF.get();
    double totalAmount = 0.0;
    for (var i = 0; i < snapshot.docs.length; i++) {
      double price = snapshot.docs[i]['price'];

      totalAmount += price;
    }
    state.totalAmountWithOutDiscount.value = totalAmount;

    return state.totalAmountWithOutDiscount.value;
  }

  //// - ====================================================================== -

  //* ------------------ Select Date ------------------

  selectDate(context, style) async {
    //* ------------------ Date Picker ------------------

    var results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        calendarViewMode: DatePickerMode.day,
        closeDialogOnCancelTapped: true,
        currentDate: DateTime.now(),
        firstDate: DateTime.now(),
        closeDialogOnOkTapped: true,
        selectedDayHighlightColor: AppColors.mainColor,
        disableYearPicker: true,
        controlsTextStyle:
            TextStyle(color: AppColors.mainColor, fontSize: 15.sp),
        weekdayLabelTextStyle: const TextStyle(color: AppColors.mainColor),
        okButton: Text(
          "OK",
          style: style.subtitle1?.copyWith(color: AppColors.mainColor),
        ),
        cancelButton: Text(
          "CANCLE",
          style: style.subtitle1?.copyWith(color: AppColors.darkColor),
        ),
      ),
      dialogSize: Size(325.w, 400.h),
      dialogBackgroundColor: AppColors.secondryColor,
      initialValue: [],
      borderRadius: BorderRadius.circular(15),
    );
    String dateString = results![0].toString();

    //= ------------------ Convert Data ------------------

    convertDate(dateString);
  }

  //// - ====================================================================== -

  //* ------------------ Convert Date ------------------

  convertDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    state.formattedDate.value = DateFormat('MMMM d yyyy').format(date);
    return state.formattedDate.value;
  }

  //// - ====================================================================== -

  //* ------------------ Select Time ------------------

  selectTime(context) async {
    state.selectedTimeSlot.value = 0;
    await appointmentRF
        .doc(state.formattedDate.value)
        .collection('time')
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isEmpty && snapshot.size == 0) {
        state.isDocAvailable.value = false;
        try {
          var dataList = [];
          String stringTime =
              await rootBundle.loadString("assets/database/time.json");
          dataList.add(jsonDecode(stringTime));
          var timeList = dataList[0]['selectedTime'];
          for (var time in timeList) {
            await appointmentRF
                .doc(state.formattedDate.value)
                .collection("time")
                .doc(time['id'])
                .set({'time': time['time'], 'isBooked': time['isBooked']});
          }
          state.isDocAvailable.value = true;
        } catch (e) {
          state.isDocAvailable.value = false;
          toastInfo(msg: "Error in Fetching Time", backgroundColor: Colors.red);
        }
      } else {
        state.isDocAvailable.value = true;
      }
    });

    //// - ====================================================================== -

    // var appointmentDoc =
    //     await appointmentRF.doc(state.formattedDate.value).get();
    // if (appointmentDoc.exists && appointmentDoc.data() != null) {
    //   state.isDocAvailable.value = true;

    //   print('-------------------------------------------Available');

    //   var appointmentSnapshot = await appointmentRF
    //       .doc(state.formattedDate.value)
    //       .collection('time')
    //       .where('isBooked', isEqualTo: false)
    //       .get();
    //   state.timeList.value = [];
    //   if (appointmentSnapshot.docs.isNotEmpty) {
    //     for (var snapshot in appointmentSnapshot.docs) {
    //       var appointmentData = snapshot.data();
    //       var time = appointmentData["time"];
    //       state.timeList.add([time]);
    //     }
    //   }
    // } else {
    //   print('-------------------------------------------Not Available');
    //   state.isDocAvailable.value = false;
    //   try {
    //     var dataList = [];
    //     String stringTime =
    //         await rootBundle.loadString("assets/database/time.json");
    //     dataList.add(jsonDecode(stringTime));
    //     var timeList = dataList[0]['selectedTime'];
    //     for (var time in timeList) {
    //       await appointmentRF
    //           .doc(state.formattedDate.value)
    //           .collection("time")
    //           .doc(time['id'])
    //           .set({'time': time['time'], 'isBooked': time['isBooked']});
    //     }
    //     state.isDocAvailable.value = true;
    //   } catch (e) {
    //     state.isDocAvailable.value = false;
    //     toastInfo(msg: "Error in Fetching Time", backgroundColor: Colors.red);
    //   }
    // }
  }

  //// - ====================================================================== -

  //* ------------------ Selected Time Slot ------------------

  selectedTimeSlot(int index) {
    state.selectedTimeSlot.value = index;
  }
  //// - ====================================================================== -

  //* ------------------ Book Appointment ------------------
  bookappointment() async {
    final servicesList = [];
    try {
      if (state.formattedDate.value == '' && state.slectedTime.value == '') {
        toastInfo(
          msg: "Please select date and time",
          backgroundColor: AppColors.darkColor,
        );
      } else if (state.slectedTime.value == '') {
        toastInfo(
          msg: "Please select time slot",
          backgroundColor: AppColors.darkColor,
        );
      }

      //* ------------------ Getting Cart Services Details ------------------

      if (state.formattedDate.value != '' && state.slectedTime.value != '') {
        String docId = state.formattedDate.value + state.slectedTime.value;
        await cartRF.get().then((snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            for (var i = 0; i < snapshot.docs.length; i++) {
              String docId = snapshot.docs[i]['docId'];
              String serviceTitle = snapshot.docs[i]['title'];
              double servicePrice = snapshot.docs[i]['price'];
              double serviceDiscount = snapshot.docs[i]['discountPrice'];
              servicesList.add({
                'docID': docId,
                'title': serviceTitle,
                'price': servicePrice,
                'Discount': serviceDiscount,
              });
            }

            print(
                'Service List -------------- ----- ${servicesList.toString()}');
          }
        });
        await bookingRF.doc(docId).set({
          "docId": docId,
          "mail": authCurrentUserMail,
          "name": authCurrentUserName,
          "services": servicesList,
          "date": state.formattedDate.value.toString(),
          "timeSlot": state.slectedTime.value.toString(),
          "price": state.totalAmount.value.toStringAsFixed(2),
          "status": "booked",
          "bookingTime": Timestamp.now()
        });
        toastInfo(
          msg: "Appointment Booked",
          backgroundColor: AppColors.darkColor,
        );

        //* ------------------ Time Slot Booking (True) ------------------
        await appointmentRF
            .doc(state.formattedDate.value)
            .collection("time")
            .doc(state.selectedTimeDocId.value.toString())
            .update({
          "isBooked": true,
        });

        //* ------------------ Clear the Cart ------------------

        clearCart();
        notification(state.slectedTime.value.toString(),
            state.formattedDate.value.toString());
        state.selectedTimeDocId.value = "";
        state.slectedTime.value = "";
      }
    } catch (e) {
      toastInfo(
        msg: "Error in Booking Appointment",
        backgroundColor: Colors.red,
      );
    }
  }

  //* ------------------ Notification ------------------

  notification(
    String slotTime,
    String date,
  ) {
    FcmServices.displyNotification(
        title: "Appointment Booked",
        body:
            "Your ${slotTime.toString()} slot on ${date.toString()} is Booked");
  }

  //// - ====================================================================== -

  //* ------------------ Clear the Cart ------------------
  clearCart() async {
    await cartRF.get().then((snapshot) {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      batch.commit().then((value) => print('All documents deleted'));
    }).catchError((error) => print('Failed to delete documents: $error'));
  }
}
