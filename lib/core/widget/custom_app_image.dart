import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AppImage extends StatelessWidget {
  final String? path;
  final double? height, width;
  final BoxFit fit;
  final Color? color;
  final String? placeholderImage; // الصورة الافتراضية في حال كان `path` null

  const AppImage(
    this.path, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.scaleDown,
    this.color,
    this.placeholderImage, // الخيار الافتراضي في حال لم يتم تمرير `path`
  });

  @override
  Widget build(BuildContext context) {
    // تحقق مما إذا كان `path` فارغاً أو null
    if (path == null || path!.isEmpty) {
      return placeholderImage != null
          ? Image.asset(
              placeholderImage!, // استخدم الصورة الافتراضية
              height: height,
              width: width,
              fit: fit,
            )
          : const SizedBox.shrink(); // أو قم بإرجاع عنصر فارغ
    }

    if (path!.endsWith("svg")) {
      return SvgPicture.asset(
        path!,
        fit: fit,
        height: height,
        width: width,
        color: color,
      );
    } else if (path!.startsWith("http")) {
      return Image.network(
        path!,
        fit: fit,
        height: height,
        width: width,
        color: color,
      );
    } else if (path!.endsWith("json")) {
      return Lottie.asset(
        path!,
        fit: fit,
        height: height,
        width: width,
      );
    } else if (path!.endsWith("jpg")) {
      return Lottie.asset(
        path!,
        fit: fit,
        height: height,
        width: width,
      );
    } else {
      return Image.asset(
        path!,
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    }
  }
}
