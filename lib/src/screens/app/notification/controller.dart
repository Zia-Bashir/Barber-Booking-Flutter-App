import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/notification/index.dart';

class NotificationController extends GetxController {
  final state = NotificationState();
  NotificationController();
  static NotificationController get to => Get.find();
}
