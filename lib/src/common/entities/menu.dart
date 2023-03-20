import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/routes/names.dart';
import 'package:the_barber/src/common/utils/my_icons_icons.dart';
import 'package:the_barber/src/screens/auth/controller.dart';

class MenuModel {
  final String? title;
  final IconData icon;
  final VoidCallback onTap;
  MenuModel({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

var controller = AuthController();
List<MenuModel> menuModel = [
  MenuModel(title: "My Profile", icon: MyIcons.avatar, onTap: () {}),
  MenuModel(
      title: "Notification",
      icon: Icons.notifications,
      onTap: () {
        Get.toNamed(AppRoutes.NOTIFICATION);
      }),
  MenuModel(
      title: "History",
      icon: MyIcons.history,
      onTap: () {
        Get.toNamed(AppRoutes.HISTORY);
      }),
  MenuModel(
      title: "Cart",
      icon: Icons.shopping_bag,
      onTap: () {
        Get.toNamed(AppRoutes.CART);
      }),
  MenuModel(title: "Setting", icon: MyIcons.setting, onTap: () {}),
  MenuModel(
      title: "Signout",
      icon: Icons.logout,
      onTap: () {
        controller.signOut();
      }),
];
