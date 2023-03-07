import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';
import 'package:the_barber/src/common/utils/app_sizes.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.textcontroller,
    required this.onPressed,
    this.hintText = '',
    required this.icon,
    this.color = AppColors.mainColor,
    this.validator,
    this.keyboard,
  }) : super(key: key);

  final TextEditingController textcontroller;
  final String? hintText;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Column(
      children: [
        Hero(
          tag: "search",
          child: SizedBox(
            width: screenWidth,
            height: 52.h,
            child: Material(
              color: Colors.transparent,
              child: TextFormField(
                controller: textcontroller,
                validator: validator,
                style: style.subtitle1?.copyWith(
                    color: Colors.black,
                    fontSize: 13.r,
                    fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  suffix: Icon(icon),
                  hintText: hintText,
                  hintMaxLines: 1,
                  hintStyle: style.subtitle1?.copyWith(
                      color: Colors.grey,
                      fontSize: 14.r,
                      fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.r),
                      borderSide: const BorderSide()),
                  contentPadding: EdgeInsets.only(left: 20.w, right: 5.w),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
