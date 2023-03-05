import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/home/index.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
