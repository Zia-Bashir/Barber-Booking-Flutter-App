import 'package:get/get.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/screens/app/cart/index.dart';

class CartController extends GetxController {
  final state = CartState();
  CartController();

  //* ------------------ Add to Cart ------------------

  addedToCart(
      {required String serviceId,
      required double servicePrice,
      required double discountPrice}) {
    return cartRF.doc(serviceId).set({
      "uid": authCurrentUserMail,
      "serviceId": serviceId,
      "price": servicePrice,
      "discountPrice": discountPrice
    });
  }
}
