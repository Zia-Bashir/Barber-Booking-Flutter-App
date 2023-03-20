import 'package:get/get.dart';
import 'package:the_barber/src/common/routes/routes.dart';
import 'package:the_barber/src/screens/app/cart/index.dart';
import 'package:the_barber/src/screens/app/detail/index.dart';
import 'package:the_barber/src/screens/app/history/index.dart';
import 'package:the_barber/src/screens/app/home/index.dart';
import 'package:the_barber/src/screens/app/notification/index.dart';
import 'package:the_barber/src/screens/app/search/index.dart';
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

    //= -- Search Route
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
    ),

    //= -- Detail Route
    GetPage(
      name: AppRoutes.DETAIL,
      page: () => const DetailScreen(),
      binding: DetailBinding(),
    ),

    //= -- Cart Route
    GetPage(
      name: AppRoutes.CART,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),

    //= -- History Route
    GetPage(
      name: AppRoutes.HISTORY,
      page: () => const HistoryScreen(),
      binding: HistoryBinding(),
    ),

    //= -- Notification Route
    GetPage(
      name: AppRoutes.NOTIFICATION,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
  ];
}
