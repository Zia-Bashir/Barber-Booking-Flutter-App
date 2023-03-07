import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';

class SearchListBuilder extends StatelessWidget {
  const SearchListBuilder({
    Key? key,
    required this.items,
    required this.style,
  }) : super(key: key);

  final List<Map<String, dynamic>> items;
  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          selectedColor: AppColors.mainColor,
          selected: true,
          leading: items[index]['discount'] == null
              ? Text(
                  '\$ ${items[index]['price']}',
                  style: style.subtitle1?.copyWith(color: AppColors.mainColor),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$ ${items[index]['price']}',
                      style: style.bodyText1
                          ?.copyWith(decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      '\$ ${items[index]['discountedPrice']}',
                      style:
                          style.subtitle1?.copyWith(color: AppColors.mainColor),
                    )
                  ],
                ),
          title: Text(
            items[index]['title'],
            style: style.subtitle1?.copyWith(color: AppColors.mainColor),
          ),
          subtitle: Text(
            '${items[index]['description']}',
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: style.bodyText2?.copyWith(color: Colors.white),
          ),
        );
      },
    );
  }
}
