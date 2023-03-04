import 'package:get/get.dart';
import 'package:the_barber/src/common/store/store.dart';
import 'package:the_barber/src/screens/auth/controller.dart';
import 'package:the_barber/src/screens/splash/index.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.put<UserStore>(UserStore());
  }
}
