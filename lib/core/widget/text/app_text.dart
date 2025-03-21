import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color?color;

  const AppText({
    super.key,
    required this.text,
    this.textAlign,
    this.textStyle,
    this.softWrap,
    this.overflow,
    this.maxLines,
     this.fontSize,
     this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.end,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: "Cairo",
      ), // ✅ يحصل على الثيم المحدث
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
    
    );
  }
}
