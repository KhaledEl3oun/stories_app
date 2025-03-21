import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/widget/text_failed/custom_text_failed.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool readOnly ;
  final void Function()? onTap;
  final String? note;
  final int? maxLines  ;
  const
  CustomInputField({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.onChanged ,
    this.readOnly = false,
    this.onTap ,
    this.note,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
        textAlign: TextAlign.start,
        label,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontFamily: "Cairo",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
    ),
        SizedBox(height: 10),
        CustomTextField(
          onTap: onTap,
          readOnly:   readOnly,
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword,
          isPassword: isPassword,
          maxLines: maxLines??1,
          onChanged: onChanged,
        ),

      ],
    );
  }
}
