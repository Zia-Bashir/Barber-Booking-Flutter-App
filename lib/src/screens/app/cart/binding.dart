import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/cart/index.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}
