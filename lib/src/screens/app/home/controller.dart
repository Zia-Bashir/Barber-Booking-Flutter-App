import 'package:get/get.dart';
import 'package:the_barber/src/common/firebase/fcm_services.dart';
import 'package:the_barber/src/screens/app/home/index.dart';

class HomeController extends GetxController {
  final state = HomeState();
  HomeController();
  @override
  void onInit() {
    FcmServices.terminateNotification();
    FcmServices.foregroundNotification();
    super.onInit();
  }
}
