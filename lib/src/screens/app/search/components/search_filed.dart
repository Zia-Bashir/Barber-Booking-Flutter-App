import 'package:flutter/material.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/screens/app/search/index.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.controller,
    required this.style,
  }) : super(key: key);

  final SearchController controller;
  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return TextField(
      //controller: controller.state.searchController,
      focusNode: controller.state.contentFocus,
      style: style.subtitle1,
      decoration: InputDecoration(
        hintText: "Search .....",
        hintMaxLines: 1,
        hintStyle: style.subtitle1,
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        suffixIcon: const Icon(
          Icons.search,
          color: AppColors.darkColor,
        ),
      ),
      onChanged: (value) {
        controller.setSearchText(value);
      },
    );
  }
}
