import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/notification/index.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
