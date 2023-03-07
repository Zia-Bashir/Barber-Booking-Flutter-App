import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/search/controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
