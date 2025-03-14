import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app_colors.dart';
import '../../fonts_manager/font_weight_helper.dart';
import '../../fonts_manager/fonts_type.dart';

class TextStyles {
  static final String _defaultFontFamily = FontsType.defaultFont;

  /// ****************** Title Styles ******************
  /// These styles are used for main and large titles in the app.
  static TextStyle get title => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.blackColor,
        fontFamily: _defaultFontFamily,
      );

  static TextStyle get largeTitle => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.blackColor,
        fontFamily: _defaultFontFamily,
      );

  static TextStyle get mediumTitle => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.blackColor,
        fontFamily: _defaultFontFamily,
      );

  /// ****************** Body Text Styles ******************
  /// These styles are used for general body text in the app.
  static TextStyle get bodyText => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textColor,
        fontFamily: _defaultFontFamily,
      );

  /// ****************** Subtitle Styles ******************
  /// These styles are for secondary text or subtitles in gray.
  static TextStyle get subtitle => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textColor.withOpacity(0.6),
        fontFamily: _defaultFontFamily,
      );

  /// ****************** Highlight Styles ******************
  /// These styles are used for highlighted text or important text.
  static TextStyle get highlight => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.primaryColor,
        fontFamily: _defaultFontFamily,
      );

  /// ****************** Button Styles ******************
  /// These styles are used for button text.
  static TextStyle get button => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.white,
        fontFamily: _defaultFontFamily,
      );

  /// ****************** Error Styles ******************
  /// These styles are used for error text or error messages.
  static TextStyle get error => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.redColor,
        fontFamily: _defaultFontFamily,
      );
}
