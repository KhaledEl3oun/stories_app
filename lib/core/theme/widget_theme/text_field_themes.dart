import 'package:flutter/material.dart';

import '../app_colors.dart';

class TextFieldThemes {
  static const double _radius8 = 10;
  static const double _width1_5 = 1.5;

  static final Color _primaryColor = AppColors.primaryColor;
  static final Color _greyColor = AppColors.customLightGrey;
  static final Color _redColor = Colors.red[400]!;
  static const Color _whiteColor = Colors.white;
  static InputDecorationTheme light = InputDecorationTheme(
    fillColor: _whiteColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: _primaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: _primaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: _primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: _redColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: _redColor),
    ),
  );

  static InputDecorationTheme dark = InputDecorationTheme(
    errorStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      // height: 1.5,
      color: _redColor,
    ),
    hintStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.3,
      color: _whiteColor,
    ),
    labelStyle: const TextStyle(color: _whiteColor),
    prefixIconColor: _greyColor,
    suffixIconColor: _greyColor,
    isCollapsed: true,
    isDense: true,
    filled: true,
    fillColor: _primaryColor,
    iconColor: _whiteColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    hoverColor: _whiteColor,
    // enabled border style
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _greyColor, width: _width1_5),
        borderRadius: const BorderRadius.all(Radius.circular(_radius8))),

    // focused border style
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _greyColor, width: _width1_5),
        borderRadius: const BorderRadius.all(Radius.circular(_radius8))),

    // error border style
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _redColor, width: _width1_5),
        borderRadius: const BorderRadius.all(Radius.circular(_radius8))),

    // focused Error border style
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _redColor, width: _width1_5),
        borderRadius: const BorderRadius.all(Radius.circular(_radius8))),
  );
}
