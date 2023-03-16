import 'package:flutter/material.dart';
import 'package:the_barber/src/common/utils/app_sizes.dart';
import 'package:the_barber/src/screens/app/history/components/components.dart';

class HistoryTabBarView extends StatelessWidget {
  const HistoryTabBarView({
    Key? key,
    required this.style,
  }) : super(key: key);

  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TabBarView(
      children: [
        SizedBox(
          width: screenWidth,

          //= ------------------ Booking Stream Builder ------------------

          child: bookingStreamBuilder(style),
        ),
        SizedBox(
          width: screenWidth,

          //= ------------------ Completed Stream Builder ------------------

          child: completedStreamBuilder(style),
        ),
      ],
    ));
  }
}
