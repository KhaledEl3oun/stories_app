import 'package:flutter/material.dart';
import 'package:stories_app/core/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final WidgetStateProperty<Color?>? backgroundColor;
  final WidgetStateProperty<Size?>? minimumSize;
  final TextStyle? textStyle;
  final String text;
  final Color? textColor;
  final Color? borderColor;
  final bool isLoading;

  const AppButton({
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textStyle,
    this.minimumSize,
    this.textColor,
    this.borderColor,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
    )
        : ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
        backgroundColor: backgroundColor,
        minimumSize: minimumSize,
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: 2)
                : BorderSide.none,
          ),
        ),
      ),
      child: Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text,
        style:textStyle?? Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: textColor ?? Colors.white,
          fontSize: 18,
           fontFamily: "ElMessiri",
        ),
      ),
    );
  }
}
