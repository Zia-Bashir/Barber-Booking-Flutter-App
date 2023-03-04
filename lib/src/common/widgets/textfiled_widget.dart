import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';

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
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 52.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
          ),
          child: TextFormField(
            controller: textcontroller,
            validator: validator,
            style: style.subtitle1?.copyWith(
                color: Colors.black,
                fontSize: 13.r,
                fontWeight: FontWeight.w300),
            decoration: InputDecoration(
              hintText: hintText,
              hintMaxLines: 1,
              hintStyle: style.subtitle1?.copyWith(
                  color: Colors.grey,
                  fontSize: 14.r,
                  fontWeight: FontWeight.w400),
              suffixIcon: IconButton(
                  onPressed: onPressed, icon: const Icon(Icons.attach_file)),
              contentPadding: EdgeInsets.only(left: 20.w, right: 5.w),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28.r),
                borderSide:
                    const BorderSide(width: 1, color: AppColors.mainColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28.r),
                borderSide:
                    const BorderSide(width: 1, color: AppColors.mainColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28.r),
                borderSide:
                    const BorderSide(width: 1, color: AppColors.mainColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
