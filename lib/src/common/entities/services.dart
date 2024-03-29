// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:the_barber/src/common/utils/app_images.dart';

class ServicesModel {
  final String? title;
  final String? imgUrl;
  final String? tag;

  ServicesModel({required this.title, required this.imgUrl, required this.tag});
}

List<ServicesModel> servicesModel = [
  ServicesModel(title: "Shaving", imgUrl: shavingImage, tag: "shaving"),
  ServicesModel(title: "Hair Care", imgUrl: hairCareImage, tag: "hair"),
  ServicesModel(title: "Beard Trimming", imgUrl: beardImage, tag: "beard"),
  ServicesModel(title: "Hair Washing", imgUrl: washingImage, tag: "washing"),
];

class ServicesListModel {
  String? serviceId;
  String? title;
  String? description;
  double? price;
  int? discount;
  double? discountedPrice;
  String? categoryName;
  String? tag;

  ServicesListModel(
      {this.serviceId,
      this.title,
      this.description,
      this.price,
      this.discount,
      this.discountedPrice,
      this.categoryName,
      this.tag});

  factory ServicesListModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ServicesListModel(
      serviceId: data?['serviceId'],
      title: data?['title'],
      description: data?['description'],
      price: data?['price'],
      discount: data?['discount'],
      discountedPrice: data?['discountedPrice'],
      categoryName: data?['categoryName'],
      tag: data?['tag'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (serviceId != null) "serviceId": serviceId,
      if (title != null) "title": title,
      if (price != null) "price": price,
      if (description != null) "description": description,
      "discount": discount,
      "discountedPrice": discountedPrice,
      if (categoryName != null) "categoryName": categoryName,
      if (tag != null) "tag": tag,
    };
  }
}
