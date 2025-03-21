import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/resource/app_images.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/button/app_button.dart';
import 'package:stories_app/core/widget/custom_header/custom_header_row.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/feature/auth/controller/auth_cubit.dart';
import 'package:stories_app/feature/auth/controller/auth_state.dart';

class VerificationPage extends StatefulWidget {
  final String email; // تمرير الإيميل من الشاشة السابقة

  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String otpCode = ""; // تخزين كود OTP المدخل

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: 
        SingleChildScrollView(
          child: AppPadding(
            child: Center(
              child: Column(
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
                  const Center(
                    child: AppText(text: 'أدخل الرقم السري المؤقت'),
                  ),
                  SizedBox(height: 50.h),

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: OtpTextField(
                      onSubmit: (value) {
                        setState(() {
                          otpCode = value; // حفظ الكود المدخل
                        });
                      },
                      numberOfFields: 4,
                      fieldHeight: 50.h,
                      fieldWidth: 50.h,
                      cursorColor: Colors.blue,
                      contentPadding: const EdgeInsets.all(2),
                      focusedBorderColor: Colors.orangeAccent,
                      showFieldAsBox: true,
                    ),
                  ),

                  const SizedBox(height: 40),

                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        context.pushNamed(AppRoutes.changePasswordPage); // الانتقال بعد النجاح
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
                              ? null
                              : () {
                                  BlocProvider.of<AuthCubit>(context)
                                      .verifyResetCode(otpCode);
                                },
                          text: state is AuthLoading ? "جاري التحقق..." : "استعادة كلمة المرور",
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
