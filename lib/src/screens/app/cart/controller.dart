import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/widgets/widget.dart';
import 'package:the_barber/src/screens/app/cart/index.dart';

class CartController extends GetxController {
  final state = CartState();
  CartController();

  @override
  void onReady() {
    updateCartProductPrice();
    getAmountAndDiscount();
    super.onReady();
  }

  //* ------------------ Add to Cart ------------------

  addedToCart(
      {required String serviceId,
      required double servicePrice,
      required String docId,
      required double discountPrice}) {
    return cartRF.doc(docId).set({
      "uid": authCurrentUserMail,
      "serviceId": serviceId,
      "price": servicePrice,
      "docId": docId,
      "discountPrice": 0.0
    });
  }

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

  getAmountAndDiscount() {
    getTotalAmount();
    getTotalDiscount();
    getPriceAfterDiscount();
  }

  //* ------------------ Total Amount of Cart Services  ------------------

  Future<double> getTotalAmount() async {
    QuerySnapshot snapshot = await cartRF.get();
    double totalPrice = 0.0;
    for (var i = 0; i < snapshot.docs.length; i++) {
      double price = snapshot.docs[i]['price'];
      print("----------------$price");
      totalPrice += price;
    }
    state.totalAmount.value = totalPrice;
    print('Total Price: ${totalPrice.toString()}');
    return state.totalAmount.value;
  }

  //* ------------------ Total Discount of Cart Services  ------------------

  Future<double> getTotalDiscount() async {
    QuerySnapshot snapshot = await cartRF.get();
    double totalDiscount = 0.0;
    for (var i = 0; i < snapshot.docs.length; i++) {
      double discount = snapshot.docs[i]['discountPrice'];
      print("----------------$discount");
      totalDiscount += discount;
    }
    state.totalDiscount.value = totalDiscount;
    print('Total Discount: ${totalDiscount.toString()}');
    return state.totalDiscount.value;
  }

  Future<double> getPriceAfterDiscount() async {
    QuerySnapshot snapshot = await cartRF.get();
    double totalDiscount = 0.0;
    double totalPrice = 0.0;
    for (var i = 0; i < snapshot.docs.length; i++) {
      double price = snapshot.docs[i]['price'];
      double discount = snapshot.docs[i]['discountPrice'];
      totalPrice += price;
      totalDiscount += discount;
    }
    //var actualDiscount = totalPrice - totalDiscount;
    state.priceAfterDiscount.value = totalPrice - totalDiscount;
    return state.priceAfterDiscount.value;
  }
}
