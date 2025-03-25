import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Container(
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
          child: AppPadding(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),
                    const CustomHeaderRow(title: 'تسجيل الدخول'),
                    SizedBox(height: 20.h),

                    /// ✅ صورة تسجيل الدخول
                    Center(
                      child: Image.asset(
                        AppImages.logoSignIn,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomInputField(
                            label: "البريد الالكتروني",
                            controller: emailController,
                            validator: xValidator([
                              IsRequired('البريد الإلكتروني مطلوب'),
                              IsEmail('البريد الإلكتروني غير صالح'),
                            ]),
                          ),
                          const SizedBox(height: 30),
                          CustomInputField(
                            isPassword: true,
                            label: 'كلمه المرور',
                            controller: passwordController,
                            validator: xValidator([
                              IsRequired('كلمة المرور مطلوبة'),
                            ]),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// ✅ نسيت كلمة المرور؟
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.forgetPasswordPage);
                      },
                      child: AppText(
                        text: 'نسيت كلمه المرور؟',
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                                color: AppColors.primaryColor, fontSize: 18),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthLoggedIn) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                              "تم تسجيل الدخول بنجاح!",
                              style: TextStyle(
                                  color: Colors.green, fontFamily: 'Elmessiri'),
                            )),
                          );
                          Future.microtask(() {
                            context.pushNamed(AppRoutes.homeScreen);
                          });
                        } else if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Center(
                          child: Column(
                            children: [
                              AppButton(
                                minimumSize:
                                    MaterialStateProperty.all(const Size(380, 50)),
                                onPressed: state is AuthLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<AuthCubit>(context).login(
                                            emailController.text,
                                            passwordController.text,
                                          );
                                        }
                                      },
                                text: state is AuthLoading
                                    ? "جاري تسجيل الدخول..."
                                    : "تسجيل الدخول",
                              ),
                              
                              Gap(5.h),
                          AppButton(
                        onPressed: () async{
                          await BlocProvider.of<AuthCubit>(context).signInAnonymously(context);
                        },
                        text:"👋🏽تسجيل الدخول كزائر",
    )
                            ],
                          ),

                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    /// ✅ ليس لديك حساب؟
                    TextPrompt(
                      primaryText: 'ليس لديك حساب؟  ',
                      actionText: 'انشئ حساب الان',
                      onTap: () {
                        context.pushNamed(AppRoutes.registerScreen);
                      },
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
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthGoogleSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "✅ تم تسجيل الدخول بنجاح: ${state.username}")),
                          );
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.homeScreen);
                        } else if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("❌ خطأ: ${state.error}")),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              AuthCubit.get(context).signInWithGoogle();
                            },
                            child: Container(
                              width: 70.w,
                              height: 70.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.grey.shade400, width: 1),
                              ),
                              child: state is AuthLoading
                                  ? CircularProgressIndicator()
                                  : Center(
                                      child: Image.asset(
                                        'assets/images/devicon_google.png',
                                        width: 30.w,
                                        height: 30.h,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 50.h),
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
