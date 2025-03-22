import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/button/app_button.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/core/widget/text_failed/custom_input_field.dart';
import 'package:stories_app/feature/drawer/controller/update_user_cubit.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';

class UpdatePassword extends StatelessWidget {
  UpdatePassword({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      body: BlocConsumer<UpdateUserCubit, UpdateUserState>(
        listener: (context, state) {
          if (state is UpdateUserSucsses) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تم تعديل كلمة المرور بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            Future.delayed(Duration(seconds: 2), () {
              context.pushNamed(AppRoutes.homeScreen);
              context.read<UpdateUserCubit>().currentPassword.clear();
              context.read<UpdateUserCubit>().password.clear();
              context.read<UpdateUserCubit>().passwordConfirm.clear();
            });
          } else if (state is UpdateUserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
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
                            onTap: () {
                              context.pushNamed(AppRoutes.notificationScreen);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              height: 40,
                              width: 40,
                              child:
                                  Image.asset('assets/images/notification.png'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AppText(
                            text: 'تعديل كلمة المرور',
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.primaryColor),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_forward))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  CustomInputField(
                    label: "كلمة المرور الحالية",
                    controller: context.read<UpdateUserCubit>().currentPassword,
                  ),
                  const SizedBox(height: 20),
                  CustomInputField(
                    label: "كلمة المرور الجديدة",
                    controller: context.read<UpdateUserCubit>().password,
                  ),
                  const SizedBox(height: 20),
                  CustomInputField(
                    label: "تأكيد كلمة المرور الجديدة",
                    controller: context.read<UpdateUserCubit>().passwordConfirm,
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: AppButton(
                      minimumSize:
                          MaterialStateProperty.all(const Size(380, 50)),
                      onPressed: () {
                        context.read<UpdateUserCubit>().userUpdata();
                      },
                      text: state is UpdateUserLoading
                          ? 'جاري التعديل..'
                          : 'تعديل',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
