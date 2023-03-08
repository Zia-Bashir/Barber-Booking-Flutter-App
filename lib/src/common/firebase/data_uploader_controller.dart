import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/entities/entities.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';

class DataUploaderController extends GetxController {
  RxInt proID = 0.obs;
  @override
  void onReady() {
    super.onReady();
    dataUploader();
  }

  //// - ====================================================================== -

  //* ------------------ If u want to upload New Data to Firestore ------------------
  /*
  Go to  ---->  assets/database/services.json
  Chnage Data.
  Go to ----> lib->src->common->helper->dependicies.dart
  Paste -- Get.put(DataUploaderController());
  */

  Future<void> dataUploader() async {
    try {
      var dataList = [];
      String stringServices =
          await rootBundle.loadString("assets/database/services.json");
      dataList.add(jsonDecode(stringServices));

      //print(dataList);

      var servicesList = dataList[0]['services'];

      //print(servicesList);
      //* ----- Services List Uploader
      for (var services in servicesList) {
        var content = ServicesListModel(
          serviceId: services['serviceId'],
          title: services['title'],
          description: services['description'],
          price: services['price'],
          categoryName: services['categoryName'],
          discount: services['discount'],
          discountedPrice: services['discountedPrice'],
          tag: services['tag'],
        );
        await servicesRF
            .withConverter(
                fromFirestore: ServicesListModel.fromFirestore,
                toFirestore: (ServicesListModel servList, options) =>
                    servList.toFirestore())
            .add(content)
            .then((value) {
          print('Completed ----- ${value.toString()}');
        });

        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
