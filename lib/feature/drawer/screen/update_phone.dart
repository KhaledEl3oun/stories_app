import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/button/app_button.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/core/widget/text_failed/custom_input_field.dart';
import 'package:stories_app/feature/auth/controller/auth_cubit.dart';
import 'package:stories_app/feature/auth/controller/auth_state.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';

class UpdatePhone extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  UpdatePhone({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      body: 
      
      Container(
         decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Theme.of(context).scaffoldBackgroundColor ==
                        const Color(0xff191201)
                    ? 'assets/images/darkBg.png' // ✅ خلفية الدارك
                    : 'assets/images/lightBg.png', // ✅ خلفية اللايت
              ),
              fit: BoxFit.cover, // ✅ جعل الصورة تغطي الشاشة بالكامل
            ),
          ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                                text: ' تعديل الهاتف',
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
                        controller: _phoneNumberController,
                        label: "الهاتف",
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 50),
              
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthUpdated) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("✅ تم تحديث رقم الهاتف بنجاح!")),
                            );
                            Navigator.pop(context);
                          } else if (state is AuthFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("❌ ${state.error}")),
                            );
                          }
                        },
                        builder: (context, state) {
                          return Center(
                            child: AppButton(
                              minimumSize: MaterialStateProperty.all(
                                const Size(380, 50),
                              ),
                              onPressed: state is AuthLoading
                                  ? null
                                  : () {
                                      String newPhoneNumber = _phoneNumberController.text.trim();
                                      if (newPhoneNumber.isNotEmpty) {
                                        AuthCubit.get(context).updateUserData(
                                          phone: newPhoneNumber,
                                        );
                                      }
                                    },
                              text: state is AuthLoading
                                  ? "جاري التحديث..."
                                  : "حفظ التعديلات",
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
