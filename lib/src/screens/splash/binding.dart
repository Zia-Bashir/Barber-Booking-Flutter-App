import 'package:get/get.dart';
import 'package:the_barber/src/screens/splash/index.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
