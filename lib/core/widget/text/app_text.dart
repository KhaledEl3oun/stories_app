import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;

  const AppText({
    super.key,
    required this.text,
    this.textAlign,
    this.textStyle,
    this.softWrap,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.end,
      style: textStyle ?? Theme.of(context).textTheme.bodyLarge, // ✅ يحصل على الثيم المحدث
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
