import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/cubit/theme_cubit.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/feature/auth/controller/auth_cubit.dart';
import 'package:stories_app/feature/favorite/controller/cubit/favorite_cubit.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      body: Drawer(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor == Colors.black
                ? Colors.grey[900]
                : Colors.white,
        child: AppPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Image.asset(
                    height: 40,
                    fit: BoxFit.cover,
                    'assets/images/logo_abc.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              _buildDrawerItem('الرئيسية', Icons.home, context, () {
                context.pushNamed(AppRoutes.homeScreen);
              }),
              const Divider(),
              _buildDrawerItem('حسابي', Icons.person, context, () {
                context.pushNamed(AppRoutes.myAccount);
              }),
              const Divider(),
              _buildDrawerItem('المفضلة', Icons.favorite, context, () {
                context.pushNamed(AppRoutes.favoriteScreen);
                context.read<FavoriteCubit>().fetchGetAllFavorite();
              }),
              const Divider(),
              _buildDrawerItem('الدعم الفني', Icons.headset_mic, context, () {
                context.pushNamed(AppRoutes.supportPage);
              }),
              const Divider(),
              _buildDrawerItem('تقييم التطبيق', Icons.star_rate, context, () {
                context.pushNamed(AppRoutes.rateAppPage);
              }),
              const Divider(),
              _buildDrawerItem('سياسة الخصوصية', Icons.privacy_tip, context,
                  () {
                context.pushNamed(AppRoutes.privacyPolicyPage);
              }),
              // const Divider(),
              //
              // AdvancedSwitch(
              //   activeColor: Colors.green,
              //   inactiveColor: Colors.grey,
              //   borderRadius: const BorderRadius.all(Radius.circular(15)),
              //   width: 41.0,
              //   height: 25.0,
              //   enabled: true,
              //   disabledOpacity: 0.5,
              //   onChanged: (value) {},
              // ),
              const Divider(),
              _buildDrawerItem('تسجيل الخروج', Icons.logout, context, () {
                AuthCubit().logout(context);
              }),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      String title, IconData icon, BuildContext context, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppText(
                text: title, textStyle: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(width: 15),
            Icon(icon, size: 24, color: Theme.of(context).iconTheme.color),
          ],
        ),
      ),
    );
  }
}
