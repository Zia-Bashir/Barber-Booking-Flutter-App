import 'package:flutter/material.dart';

class MyTextWidget extends StatelessWidget {
  const MyTextWidget(
      {super.key,
      required this.title,
      required this.style,
      this.align = TextAlign.center,
      this.line = 1,
      this.overflow});

  final String title;
  final TextAlign align;
  final TextStyle? style;
  final int? line;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: line,
      style: style,
      textAlign: align,
      overflow: overflow,
    );
  }
}
