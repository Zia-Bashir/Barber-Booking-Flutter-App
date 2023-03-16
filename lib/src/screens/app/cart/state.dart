import 'package:get/get.dart';

class CartState {
  RxDouble servicesPrice = 0.0.obs;
  RxDouble discount = 0.0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxDouble totalAmountWithOutDiscount = 0.0.obs;
  var formattedDate = ''.obs;
  var slectedTime = ''.obs;
  var timeList = [].obs;
  var isDocAvailable = false.obs;
  var selectedTimeSlot = 0.obs;
  var selectedTimeDocId = ''.obs;
  var cartBookingList = [].obs;
}
