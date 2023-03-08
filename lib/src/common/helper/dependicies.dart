import 'package:get/get.dart';

import '../services/storage.dart';

@override
Future<void> initState() async {
  Get.put(StorageServices());
  //Get.put(DataUploaderController());
  // Get.lazyPut<ServicesController>(() => ServicesController());
  // Get.lazyPut<SearchController>(() => SearchController());
  // Get.lazyPut<DetailController>(() => DetailController());
}
