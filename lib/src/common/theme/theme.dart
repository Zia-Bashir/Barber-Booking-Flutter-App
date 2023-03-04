import 'package:flutter/material.dart';
import 'package:the_barber/src/common/theme/theme_index.dart';

class MyTheme {
  MyTheme._();
  //= Light Theme
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,

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
