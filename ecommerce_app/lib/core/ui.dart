import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xfff45b1f);

  static const Color blackGrey = Color(0xff777777);
  static const Color lightGrey = Color(0xffB2B6BD);

  static const Color textColor = Color(0xff211500);

  static const Color white = Colors.white;
}

class AppStyles {
  static const TextStyle h1 =
      TextStyle(fontSize: 109.66, color: AppColors.textColor);

  static const TextStyle h2 =
      TextStyle(fontSize: 67.77, color: AppColors.textColor);

  static const TextStyle h3 =
      TextStyle(fontSize: 41.89, color: AppColors.textColor);

  static const TextStyle h4 =
      TextStyle(fontSize: 25.89, color: AppColors.textColor);

  static const TextStyle h5 =
      TextStyle(fontSize: 16, color: AppColors.textColor);

  static const TextStyle h6 =
      TextStyle(fontSize: 9.89, color: AppColors.textColor);
}

class Themes {
  static ThemeData defaultTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.white,
          iconTheme: IconThemeData(color: AppColors.textColor),
          titleTextStyle: AppStyles.h4),
      colorScheme: const ColorScheme.light(
          primary: AppColors.primaryColor, secondary: AppColors.primaryColor));
}
