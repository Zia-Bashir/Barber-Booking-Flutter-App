import 'package:get/get.dart';
import 'package:the_barber/src/screens/splash/controller.dart';

import '../services/storage.dart';

@override
Future<void> initState() async {
  Get.put(StorageServices());
  Get.put(SplashController());
}
