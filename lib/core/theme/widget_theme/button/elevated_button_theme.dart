import 'package:flutter/material.dart';
import '../../themes.dart';
import '../text/text_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonThemes {
  // Light Theme Elevated Button
  static ElevatedButtonThemeData get light => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(200.w, 50.h),
          // fixedSize: Size(200, 100),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          //disabledForegroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 2.0,
        ),
      );

  // Dark Theme Elevated Button
  static ElevatedButtonThemeData get dark => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          textStyle: TextStyles.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 2.0,
        ),
      );
}
