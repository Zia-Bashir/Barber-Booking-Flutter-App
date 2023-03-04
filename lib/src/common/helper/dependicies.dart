import 'package:get/get.dart';

import '../services/storage.dart';

@override
Future<void> initState() async {
  Get.put(StorageServices());
}
