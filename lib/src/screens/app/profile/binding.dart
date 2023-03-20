import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/home/index.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
