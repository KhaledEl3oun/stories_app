
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppPadding extends StatelessWidget {
  final double horizontal, vertical;

  final Widget child;

  const AppPadding(
      {super.key,
        this.vertical = 16,
        this.horizontal = 20,
        required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal.h, vertical: vertical.w),
      child: child,
    );
  }
}
