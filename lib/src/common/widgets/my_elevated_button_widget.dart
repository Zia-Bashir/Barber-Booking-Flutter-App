import 'package:flutter/Material.dart';
import 'package:the_barber/src/common/widgets/mytext_widget.dart';

class MyElevatedButtonWidget extends StatelessWidget {
  const MyElevatedButtonWidget({
    Key? key,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  final String text;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: ontap,
              style: Theme.of(context).elevatedButtonTheme.style,
              child: MyTextWidget(
                title: text,
                style: Theme.of(context).textTheme.headline4,
              )),
        ),
      ],
    );
  }
}
