import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/widgets/widget.dart';
import 'package:the_barber/src/screens/app/services/components/components.dart';

import 'package:the_barber/src/screens/app/services/index.dart';

class ServicesScreen extends GetView<ServicesController> {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.secondryColor,
      appBar: buildAppBar(context, controller),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.h, right: 20, left: 20),
            child: const AnimatedTitleWithBarWidget(
              text: "Services List",
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),

                //* ------------------ Stream Builder ------------------

                child: ServicesListStream(controller: controller)),
          ),
        ],
      ),
    );
  }
}
