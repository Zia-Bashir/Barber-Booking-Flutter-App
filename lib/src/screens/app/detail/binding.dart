import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/detail/controller.dart';

class DetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}
