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

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: AppPadding(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const CustomHeaderRow(title: 'استعادة كلمة المرور'),
                  SizedBox(height: 30.h),
                  Center(
                    child: Image.asset(
                      AppImages.logoForgetPass,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const AppText(
                    textAlign: TextAlign.center,
                    text: 'ادخل البريد الالكتروني أو رقم الهاتف المربوط بحسابك لاستلام الرقم السري المؤقت',
                  ),
                  SizedBox(height: 40.h),
                  CustomInputField(
                    controller: emailController,  // 🔹 تأكد من ربط الكنترولر
                    label: "البريد الإلكتروني",
                    validator: xValidator([
                      IsRequired('يرجى إدخال البريد الإلكتروني'),
                    ]),
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          context.pushReplacementNamed(AppRoutes.verificationPage,
                          arguments:{"email": emailController.text.trim()} );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return state is AuthLoading
                            ? const CircularProgressIndicator()
                            : AppButton(
                                minimumSize: MaterialStateProperty.all(const Size(380, 50)),
                                onPressed: () {
                                  AuthCubit.get(context).forgotPassword(emailController.text.trim());
                                },
                                text: 'استعادة كلمة المرور',
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
