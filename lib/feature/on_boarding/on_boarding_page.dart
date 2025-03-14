import 'package:flutter/material.dart';
import 'on_boarding.dart';
class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPadding(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                Center(
                  child: Image.asset('assets/images/on_boarding_page1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 45.h),
                const AppText(
                  text: 'مرحبًا بك! تعلم الإنجليزية بطريقة ممتعة ومسلية من خلال القصص الجميلة والأنشطة التفاعلية',
                ),
                SizedBox(height: 80.h),
                Center(
                  child: CircularButtonWithBorder(
                    onPressed: () {
                      context.pushNamed(AppRoutes.onBoardingScreen2);
                    },
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
