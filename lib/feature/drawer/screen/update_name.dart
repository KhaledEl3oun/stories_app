import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/button/app_button.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/core/widget/text_failed/custom_input_field.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';

class UpdateName extends StatelessWidget {
  UpdateName({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      body: 
      
      SingleChildScrollView(
        child: AppPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/images/moon.png'),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap:() {
                          context.pushNamed(AppRoutes.notificationScreen);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          height: 40,
                          width: 40,
                          child: Image.asset('assets/images/notification.png'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AppText(
                        text: ' تعديل الاسم',
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.primaryColor),
                      ),
                      const SizedBox(width: 10),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_forward))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              CustomInputField(
                
                label: "الاسم",
                onChanged: (value) {},
              ),
              const SizedBox(height: 50),

              Center(
                child: AppButton(
                  minimumSize: MaterialStateProperty.all(const Size(380, 50)),
                  onPressed: () {
                    context.pushNamed(AppRoutes.homeScreen);

                  },
                  text: 'تسجيل الدخول',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
