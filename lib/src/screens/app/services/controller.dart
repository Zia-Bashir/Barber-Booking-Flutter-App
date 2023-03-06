import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/services/index.dart';

class ServicesController extends GetxController {
  final state = ServicesState();
  ServicesController();

  @override
  void onInit() {
    //* ---- Getting Parameter ------
    var data = Get.parameters;
    state.servicesId = int.parse(data['index']!);
    state.tag = data['tag']!;
    super.onInit();
  }
}
