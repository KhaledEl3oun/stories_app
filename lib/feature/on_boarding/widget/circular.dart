
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/theme/app_colors.dart';

class CircularButtonWithBorder extends StatelessWidget {
  final VoidCallback onPressed;

  const CircularButtonWithBorder({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 100.w,
          height: 100.h,
          child: CustomPaint(
            painter: HalfVerticalCirclePainter(),
          ),
        ),
        Positioned(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.all(20.w),
              backgroundColor: AppColors.primaryColor,
              elevation: 5,
            ),
            child: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
class HalfVerticalCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint leftPaint = Paint()
      ..color = Colors.orange.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final Paint rightPaint = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57,
      3.14,
      false,
      leftPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      1.57,
      3.14,
      false,
      rightPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
