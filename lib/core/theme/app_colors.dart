import 'package:flutter/material.dart';

class AppColors {
  // Primary color - Bright Red for blood donation theme
  static Color primaryColor = const Color(0xffDDA108);

  // Secondary shades to complement the primary color
  static Color primaryColorLight = const Color(0xffFFB3B3); // Lighter shade of red for backgrounds and accents
  static Color primaryColorDark = const Color(0xffCC3A3A); // Darker shade for borders or darker accents

  // Supporting colors
  static Color redColor = const Color(0xffFF4747); // Matches primary
  static Color warningColor = const Color(0xffFFA726); // Orange for warnings
  static Color successColor = const Color(0xff4CAF50); // Green for success indicators
  static Color blueColor = const Color(0xff1976D2); // Blue for informational text or buttons

  // Text colors
  static Color fontColor = const Color(0xffF2F2F2); // Light font color for darker backgrounds
  static Color blackColor = const Color(0xff333333); // Slightly softer black for text
  static Color customGrey = const Color(0xff707070);
  static Color grey = const Color(0xff9D9D9D);
  static Color lightGrey = const Color(0xffF5F5F5); // Light grey for subtle background sections
  static Color customLightGrey = const Color(0xffFAFAFA); // Another light background option
  static Color backgroundColor = const Color(0xffFFF9F9); // Background color slightly tinted with red
  static Color backgroundColor2 = const Color(0xffFFF5F5); // Secondary background with light red tint
  static Color white = const Color(0xffffffff); // Pure white for contrast
  static Color blackFontColor = const Color(0xff666666); // Dark grey for font

  // Additional accent colors
  static Color darkRed = const Color(0xffA03026); // Dark red for icons or subtle accents
  static Color green = const Color(0xff4CAF50); // Green for success messages
  static Color orange = const Color(0xffFFA726); // Orange for warnings and highlights
  static Color cyan = const Color(0xff2FAAB8); // Cyan as an accent color

  // Opacity and transparency options
  static Color textBottomNavColor = const Color(0xffFF4747).withOpacity(0.35); // Bottom navigation text
  static Color greyLightFilter = const Color(0xffFAFAFA);
  static Color transparent = Colors.transparent;

  // Colors for specific UI elements
  static Color backgroundScaffold = const Color(0xffFFF9F9); // Scaffold background
  static Color backgroundAppBar = const Color(0xffffffff); // App bar background
  static Color backgroundSideBar = const Color(0xffFFF5F5); // Sidebar background with a light red tint
  static Color headerTable = const Color(0xffFFEAEA); // Light red for table headers

  // Text-related colors
  static Color labelColor = const Color(0xff959595); // Label color
  static Color textColor = const Color(0xff3D3D3D); // Dark grey for primary text
  static Color textInTableColor = const Color(0xff474747); // Table text color
  static Color textHintColor = const Color(0xff787878); // Hint text color
  static Color textHeaderPageColor = const Color(0xff4D4D4D); // Header text color
  static Color backgroundTextFailedUnFocused = const Color(0xffF7F7F7); // Background for unfocused fields

  // Colors for shimmer effect
  static Color baseColorShimmer = const Color(0xFFE0E0E0); // Base shimmer
  static Color highlightColorShimmer = const Color(0xFFF5F5F5); // Highlight for shimmer

  // Additional colors for layout
  static Color scaffoldBackground = const Color(0xffFFF9F9); // Scaffold background for light theme
  static Color appBarBackground = const Color(0xffffffff);

  static var yellow = Colors.yellow; // App bar background for contrast
}
