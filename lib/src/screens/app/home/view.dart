import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/screens/app/home/components/components.dart';
import 'package:the_barber/src/screens/app/home/index.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.darkColor,
        body: ZoomDrawer(
          controller: controller.state.zoomDrawerController,
          style: DrawerStyle.defaultStyle,
          menuScreen: MenuScreen(
            controller: controller,
            style: style,
          ),
          mainScreen: MainScreen(
            controller: controller,
            style: style,
          ),
          borderRadius: 24.0,
          showShadow: true,
          drawerShadowsBackgroundColor: const Color.fromARGB(255, 76, 91, 136),
          slideWidth: MediaQuery.of(context).size.width * .65,
          openCurve: Curves.fastOutSlowIn,
          closeCurve: Curves.bounceIn,
          mainScreenTapClose: true,
          angle: 0,
          mainScreenOverlayColor: Colors.transparent,
        ),
      );
    });
  }
}
