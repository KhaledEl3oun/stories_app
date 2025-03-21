import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/resource/app_images.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/button/app_button.dart';
import 'package:stories_app/core/widget/custom_header/custom_header_row.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/core/widget/text_failed/custom_input_field.dart';
import 'package:stories_app/feature/auth/controller/auth_cubit.dart';
import 'package:stories_app/feature/auth/controller/auth_state.dart';
import 'package:x_validators/x_validators.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        
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
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const CustomHeaderRow(title: 'استعاده كلمه المرور'),
                    SizedBox(height: 30.h),
                    
                    Center(
                      child: Image.asset(
                        AppImages.logoForgetPass,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    const Center(
                      child: AppText(text: 'ادخل  كلمة المرور الجديدة'),
                    ),
                    SizedBox(height: 40.h),
           
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomInputField(
                            label: "كلمة المرور الجديدة",
                            controller: newPasswordController,
                            validator: xValidator([
                              IsRequired('كلمة المرور مطلوبة'),
                              MinLength(6, 'يجب أن تكون كلمة المرور على الأقل 6 أحرف'),
                            ]),
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 20),
                          CustomInputField(
                            label: "تأكيد كلمة المرور الجديدة",
                            controller: confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى تأكيد كلمة المرور";
                              } else if (value != newPasswordController.text) {
                                return "كلمتا المرور غير متطابقتين";
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
           
                    const SizedBox(height: 30),
           
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                          context.pushNamed(AppRoutes.complatePage); 
                        } else if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Center(
                          child: AppButton(
                            minimumSize: MaterialStateProperty.all(const Size(380, 50)),
                            onPressed: state is AuthLoading
                                ? () {} // ✅ تعطيل الزر أثناء التحميل
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthCubit>(context).resetPassword(
                                        newPasswordController.text,
                                        confirmPasswordController.text,
                                      );
                                    }
                                  },
                            text: state is AuthLoading ? "جاري الحفظ..." : "حفظ",
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
                   ),
         ),
      ),
    );
  }
}
