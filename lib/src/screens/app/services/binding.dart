import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/services/index.dart';

class ServicesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesController>(() => ServicesController());
  }
}
