import 'package:flutter/material.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';
import 'package:stories_app/feature/home/widget/custom_row_header.dart';

class MyAccount extends StatelessWidget {
  MyAccount({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: AppPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 40),
              AppBarCustom(title: 'حسابي',scaffoldKey: _scaffoldKey,),
              const SizedBox(height: 40),
              const Center(child: CircleAvatar(radius: 50)),
              const SizedBox(height: 20),
              ProfileItem(
                title: 'الاسم',
                value: 'عمر محمد',
                onTap: () {
                  context.pushNamed(AppRoutes.updateName);
                },
              ),
              ProfileItem(
                title: 'الهاتف',
                value: '010123456789',
                onTap: () {
                  context.pushNamed(AppRoutes.updatePhone);

                },
              ),
              ProfileItem(
                title: 'البريد الالكترونى',
                value: 'omarmohamed@example.com',
                onTap: () {
                  context.pushNamed(AppRoutes.updateEmail);
                },
              ),
              ProfileItem(
                title: 'كلمة المرور',
                value: '********',
                onTap: () {
                  context.pushNamed(AppRoutes.updatePassword);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const ProfileItem({
    required this.title,
    required this.value,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Image.asset('assets/images/edit.png'),
            ),
            AppText(text: title),
          ],
        ),
        AppText(
          text: value,
          textStyle: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
