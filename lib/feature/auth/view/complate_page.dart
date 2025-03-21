import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/resource/app_images.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/button/app_button.dart';
import 'package:stories_app/core/widget/custom_header/custom_header_row.dart';
import 'package:stories_app/core/widget/text/app_text.dart';

class ComplatePage extends StatelessWidget {
  const ComplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Container(
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Theme.of(context).scaffoldBackgroundColor == const Color(0xff191201)
                  ? 'assets/images/darkBg.png' // ✅ خلفية الدارك
                  : 'assets/images/lightBg.png', // ✅ خلفية اللايت
            ),
            fit: BoxFit.cover, // ✅ جعل الصورة تغطي الشاشة بالكامل
          ),
        ),
         child: SingleChildScrollView(
          child: AppPadding(
            child: Column(
              children: [
                const SizedBox(height: 30,),
                const CustomHeaderRow(title: 'استعاده كلمه المرور',),
                Center(
                  child: Image.asset(
                    AppImages.complatePass,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20.h),
                const Center(
                  child: AppText(text: 'تم استعادة كلمة المرور بنجاح'),
                ),
                SizedBox(height: 40.h),
                Center(
                  child: AppButton(
                    minimumSize: MaterialStateProperty.all(Size(380.w, 50.h)),
                    onPressed: () {
                      context.pushNamed(AppRoutes.loginScreen);
                    },
                    text: 'تسجيل الدخول',
                  ),
                ),
              ],
            ),
          ),
               ),
       ),
    );
  }
}
