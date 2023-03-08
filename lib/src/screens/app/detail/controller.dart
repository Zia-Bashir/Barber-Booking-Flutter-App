import 'package:get/get.dart';
import 'package:the_barber/src/screens/app/detail/index.dart';

class DetailController extends GetxController {
  final state = DetailState();
  DetailController();
  @override
  void onInit() {
    //* ---- Getting Parameter ------
    var data = Get.parameters;
    state.servicesId = data['id']!;
    state.servicesTitle = data['title']!;

    print('2 ----- ${state.servicesId}');

    print('2 ----- ${state.servicesTitle}');

    super.onInit();
  }
}
