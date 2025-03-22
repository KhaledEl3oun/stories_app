import 'package:flutter/material.dart';
import 'on_boarding.dart';

class OnBoardingPage2 extends StatelessWidget {
  const OnBoardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPadding(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Image.asset(
                    'assets/images/on_boarding_page2.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 40.h),
                const AppText(
                    text: 'سجل الآن واستمتع بأفضل تجربة تعليمية للأطفال.'),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: 20,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                        minimumSize:
                            MaterialStateProperty.all(const Size(380, 50)),
                        text: 'إنشاء حساب',
                        onPressed: () {
                          context.pushNamed(AppRoutes.registerScreen);
                        },
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        textColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: AppButton(
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: 20,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                        minimumSize:
                            MaterialStateProperty.all(const Size(380, 50)),
                        onPressed: () {
                          context.pushNamed(AppRoutes.loginScreen);
                        },
                        text: 'تسجيل الدخول',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                TextPrompt(
                  primaryText: ' ',
                  actionText: 'المتابعة كزائر',
                  onTap: () {},
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade400,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        "أو",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade400,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.grey.shade400, width: 1),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/devicon_google.png',
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
