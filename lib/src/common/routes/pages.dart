import 'package:get/get.dart';
import 'package:the_barber/src/common/routes/routes.dart';
import 'package:the_barber/src/screens/app/home/index.dart';
import 'package:the_barber/src/screens/app/services/index.dart';
import 'package:the_barber/src/screens/auth/index.dart';
import 'package:the_barber/src/screens/splash/index.dart';

class AppPages {
  static List<GetPage> routes = [
    //= -- Initial Route
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    //= -- Auth Route
    GetPage(
      name: AppRoutes.AUTH,
      page: () => const AuthScreen(),
      binding: AuthBinding(),
    ),

    //= -- Home Route
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),

    //= -- Services Route
    GetPage(
      name: AppRoutes.SERVICES,
      page: () => const ServicesScreen(),
      binding: ServicesBinding(),
    ),
  ];
}
