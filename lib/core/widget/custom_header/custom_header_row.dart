
import 'package:flutter/material.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/widget/text/app_text.dart';

class CustomHeaderRow extends StatelessWidget {
  final String title;

  const CustomHeaderRow({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppText(
          text: title,
          color: AppColors.primaryColor,
          fontSize: 20,
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_forward,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
