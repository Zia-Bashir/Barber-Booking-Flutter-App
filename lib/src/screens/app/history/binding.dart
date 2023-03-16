import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/history/controller.dart';

class HistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}
