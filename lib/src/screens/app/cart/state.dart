import 'package:get/get.dart';

class CartState {
  RxDouble servicesPrice = 0.0.obs;
  RxDouble discount = 0.0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxDouble totalDiscount = 0.0.obs;
  RxDouble priceAfterDiscount = 0.0.obs;
}
