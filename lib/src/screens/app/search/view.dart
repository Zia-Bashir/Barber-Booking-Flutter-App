import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/utils/app_sizes.dart';
import 'package:the_barber/src/screens/app/search/components/components.dart';
import 'package:the_barber/src/screens/app/search/index.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.secondryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //= ------------------ Hero Animation of Search Filed ------------------

            Hero(
              tag: "search",
              child: SizedBox(
                height: 50.h,
                width: screenWidth,
                child: Material(
                  color: AppColors.mainColor,

                  //* ------------------ Search Filed ------------------

                  child: SearchField(
                    controller: controller,
                    style: style,
                  ),
                ),
              ),
            ),

            //* ------------------ OBX Search List ------------------

            Expanded(
              child: Obx(() {
                final List<Map<String, dynamic>> items =
                    controller.filteredItems;
                return SearchListBuilder(items: items, style: style);
              }),
            )
          ],
        ),
      ),
    );
  }
}
