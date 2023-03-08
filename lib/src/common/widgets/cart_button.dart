import 'package:flutter/material.dart';
import 'package:the_barber/src/common/firebase/firebase.dart';
import 'package:the_barber/src/common/utils/utils.dart';
import 'package:badges/badges.dart' as badges;

class CartButton extends StatelessWidget {
  const CartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: badges.Badge(
        badgeContent: StreamBuilder(
          stream: cartRF.snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Text('0');
            } else {
              return Text(
                snapshot.data!.docs.length.toString(),
              );
            }
          },
        ),
        badgeAnimation: const badges.BadgeAnimation.rotation(
          animationDuration: Duration(seconds: 1),
          colorChangeAnimationDuration: Duration(seconds: 1),
          loopAnimation: false,
          curve: Curves.fastOutSlowIn,
          colorChangeAnimationCurve: Curves.easeInCubic,
        ),
        badgeStyle: const badges.BadgeStyle(
          shape: badges.BadgeShape.circle,
          badgeColor: AppColors.darkColor,
        ),
        child: const Icon(
          Icons.shopping_bag,
          color: AppColors.secondryColor,
        ),
      ),
    );
  }
}
