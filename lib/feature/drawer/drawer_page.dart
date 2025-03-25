import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
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

    return Directionality(
      textDirection: TextDirection.rtl, // ✅ جعل المحتوى يبدأ من اليمين
      child: Drawer(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor == Color(0xff191201)
                 ? Color(0xff2b1e08)
              : Colors.white,
        child: AppPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end, // ✅ محاذاة للعناصر لليمين
            children: [
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                    height: 40,
                    fit: BoxFit.cover,
                    'assets/images/logo_abc.png'),
              ),
              const SizedBox(height: 10),
              _buildDrawerItem('الرئيسية', Icons.home, context, () {
                context.pushNamed(AppRoutes.homeScreen);
              }),
              const Divider(),
              _buildDrawerItem('حسابي', Icons.person, context, () {
  User? user = FirebaseAuth.instance.currentUser;
  String? apiToken = GetStorage().read('token');
  if ((user == null || user.isAnonymous) && (apiToken == null || apiToken.isEmpty) ){
    // ❌ المستخدم غير مسجل - عرض رسالة تحذير
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'يرجى تسجيل الدخول أولًا للدخول لهذه الصفحه!',
          style: TextStyle(fontFamily: 'ElMessiri',color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }
                context.pushNamed(AppRoutes.myAccount);
              }),
              const Divider(),
              _buildDrawerItem('المفضلة', Icons.favorite, context, () {
                 User? user = FirebaseAuth.instance.currentUser;
                 String? apiToken = GetStorage().read('token');
  
  if ((user == null || user.isAnonymous) && (apiToken == null || apiToken.isEmpty) ){
    // ❌ المستخدم غير مسجل - عرض رسالة تحذير
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'يرجى تسجيل الدخول أولًا للدخول لهذه الصفحه!',
          style: TextStyle(
            fontFamily: 'ElMessiri',color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }
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
              _buildDrawerItem('سياسة الخصوصية', Icons.privacy_tip, context, () {
                context.pushNamed(AppRoutes.privacyPolicyPage);
              }),
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
          mainAxisAlignment: MainAxisAlignment.end, // ✅ يجعل الأيقونة قبل النص
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
