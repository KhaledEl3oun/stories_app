
import 'package:flutter/material.dart';
import 'package:stories_app/core/theme/app_colors.dart';

class TextPrompt extends StatelessWidget {
  final String primaryText;
  final String actionText;
  final VoidCallback onTap;

  const TextPrompt({
    super.key,
    required this.primaryText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: primaryText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontFamily: "cairo"
                ),
              ),
              TextSpan(
                text: actionText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w400,
                   fontFamily: "cairo"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
