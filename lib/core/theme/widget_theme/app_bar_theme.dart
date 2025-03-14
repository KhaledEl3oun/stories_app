import 'package:flutter/services.dart';

import '../themes.dart';

class AppBarThemes {
  static AppBarTheme light = AppBarTheme(
     backgroundColor: AppColors.transparent,
    shadowColor: AppColors.transparent,
    centerTitle: false,
    scrolledUnderElevation: 0,
    elevation: 0,
    iconTheme: IconThemeData(
      color: AppColors.blackColor,
      size: 20,
    ),
    titleTextStyle: TextStyle(
      color: AppColors.blackColor,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
  );

  static AppBarTheme dark = AppBarTheme(
    backgroundColor: AppColors.customLightGrey,
    shadowColor: AppColors.customLightGrey.withOpacity(0.2),
    elevation: 2.0,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: AppColors.customLightGrey,
      size: 20,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.primaryColor,
      size: 24,
    ),
    titleTextStyle: TextStyle(
      color: AppColors.primaryColor,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
  );
}
