import 'package:the_barber/src/common/utils/app_images.dart';

class ServicesModel {
  final String? title;
  final String? imgUrl;

  ServicesModel({
    required this.title,
    required this.imgUrl,
  });
}

List<ServicesModel> servicesModel = [
  ServicesModel(title: "Shaving", imgUrl: shavingImage),
  ServicesModel(title: "Hair Care", imgUrl: hairCareImage),
  ServicesModel(title: "Beard Trimming", imgUrl: beardImage),
  ServicesModel(title: "Hair Washing", imgUrl: washingImage),
];
