import 'package:get/get.dart';
import 'package:the_barber/src/common/utils/utils.dart';
import 'package:the_barber/src/screens/splash/index.dart';

import '../../common/routes/routes.dart';
import '../../common/services/storage.dart';

class SplashController extends GetxController {
  final state = SplashState();
  SplashController();

  Future<void> startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    state.animate.value = true;

    state.logIn = StorageServices.to.getBool(LOGIN_STATE);

    Future.delayed(
      const Duration(seconds: 3),
      (() {
        if (state.logIn == true) {
          Get.offAllNamed(AppRoutes.HOME);
        } else {
          Get.offAllNamed(AppRoutes.AUTH);
        }
      }),
    );
  }
}
