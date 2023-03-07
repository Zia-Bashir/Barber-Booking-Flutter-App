import 'package:flutter/material.dart';
import 'package:the_barber/src/common/theme/theme_index.dart';
import 'package:the_barber/src/common/utils/app_colors.dart';

class MyTheme {
  MyTheme._();
  //= Light Theme
  final Color primaryColor = Colors.blue;
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.mainColor,
      primarySwatch: MaterialColor(
        Colors.white.value,
        {
          50: Colors.white.withOpacity(0.1),
          100: Colors.white.withOpacity(0.2),
          200: Colors.white.withOpacity(0.3),
          300: Colors.white.withOpacity(0.4),
          400: Colors.white.withOpacity(0.5),
          500: Colors.white.withOpacity(0.6),
          600: Colors.white.withOpacity(0.7),
          700: Colors.white.withOpacity(0.8),
          800: Colors.white.withOpacity(0.9),
          900: Colors.white.withOpacity(1.0),
        },
      ),

      //* -- Text Theme
      textTheme: AppTextTheme.lightTextTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme);
  //= Dark Theme
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.orange,

      //* -- Text Theme
      textTheme: AppTextTheme.darkTextTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme);
}
