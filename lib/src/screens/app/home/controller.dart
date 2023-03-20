import 'package:get/get.dart';
import 'package:the_barber/src/common/firebase/fcm_services.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/services/storage.dart';
import 'package:the_barber/src/common/utils/utils.dart';
import 'package:the_barber/src/screens/app/home/index.dart';

class HomeController extends GetxController {
  final state = HomeState();
  HomeController();
  @override
  void onInit() {
    FcmServices.terminateNotification();
    FcmServices.foregroundNotification();
    updateFcmToken();
    super.onInit();
  }

  //* ------------------ Update FCM Token ------------------

  updateFcmToken() async {
    var fcmToken = StorageServices.to.getString(STORAGE_FCM_TOKEN_KEY);
    var id = StorageServices.to.getString(STORAGE_USER_TOKEN_KEY);
    await userRF.where("id", isEqualTo: id).get().then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.update({
          "fcmtoken": fcmToken,
        });
      }
    });
  }

  void toggleDrawer() {
    state.zoomDrawerController.toggle?.call();
    update();
  }
}
