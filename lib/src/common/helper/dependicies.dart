import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/search/index.dart';
import 'package:the_barber/src/screens/app/services/controller.dart';

import '../services/storage.dart';

@override
Future<void> initState() async {
  Get.put(StorageServices());
  //Get.put(DataUploaderController());
  Get.lazyPut<ServicesController>(() => ServicesController());
  Get.lazyPut<SearchController>(() => SearchController());
}
