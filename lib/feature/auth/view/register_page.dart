import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/resource/app_images.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/theme/cubit/theme_cubit.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/button/app_button.dart';
import 'package:stories_app/core/widget/button/text_prompt.dart';
import 'package:stories_app/core/widget/custom_header/custom_header_row.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/core/widget/text_failed/custom_input_field.dart';
import 'package:stories_app/feature/auth/controller/auth_cubit.dart';
import 'package:stories_app/feature/auth/controller/auth_state.dart';
import 'package:x_validators/x_validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: AppPadding(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  const CustomHeaderRow(title: 'انشاء حساب'),
                  SizedBox(height: 20.h),
                  Center(
                    child: Image.asset(
                      AppImages.logoSignUp,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInputField(
                          label: "الاسم",
                          controller: nameController,
                          validator: xValidator([
                            IsRequired('يجب إدخال الاسم'),
                          ]),
                        ),
                        const SizedBox(height: 30),
                        CustomInputField(
                          label: "البريد الالكتروني",
                          controller: emailController,
                          validator: xValidator([
                            IsRequired('يجب إدخال البريد الإلكتروني'),
                            IsEmail('البريد الإلكتروني غير صالح'),
                          ]),
                        ),
                        const SizedBox(height: 30),
                        CustomInputField(
                          label: "الهاتف",
                          controller: phoneController,
                        ),
                        const SizedBox(height: 30),
                        CustomInputField(
                          isPassword: true,
                          label: 'كلمة المرور',
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'كلمة المرور مطلوبة';
                            }
                            if (value.length < 8) {
                              return 'يجب أن تكون كلمة المرور على الأقل 8 أحرف';
                            }
                            if (!RegExp(
                                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*._-])')
                                .hasMatch(value)) {
                              return 'يجب أن تحتوي كلمة المرور على حرف كبير، حرف صغير، رقم، ورمز خاص (!@#\$%^&*._-)';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        CustomInputField(
                          isPassword: true,
                          label: 'تأكيد كلمة المرور',
                          controller: passwordConfirmController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "يرجى تأكيد كلمة المرور";
                            } else if (value != passwordController.text) {
                              return "كلمتا المرور غير متطابقتين";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthRegistered) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("تم إنشاء الحساب بنجاح!")),
                        );
                        Future.delayed(const Duration(seconds: 1), () {
                          context.pushNamed(AppRoutes.loginScreen);
                        });
                      } else if (state is AuthFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: AppButton(
                          minimumSize:
                              MaterialStateProperty.all(const Size(380, 50)),
                          onPressed: state is AuthLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthCubit>(context)
                                        .register(
                                      nameController.text,
                                      emailController.text,
                                      phoneController.text,
                                      passwordController.text,
                                      passwordConfirmController.text,
                                    );
                                  }
                                },
                          text: state is AuthLoading
                              ? "جاري التسجيل..."
                              : "إنشاء حساب",
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextPrompt(
                    primaryText: ' لديك حساب بالفعل ؟  ',
                    actionText: ' سجل الان',
                    onTap: () {
                      context.pushNamed(AppRoutes.loginScreen);
                    },
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
