import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/theme/cubit/theme_cubit.dart';
import 'package:stories_app/core/widget/custom_app_image.dart';
import 'package:stories_app/core/widget/text/app_text.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  AppBarCustom({
    Key? key,
    required this.title,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 400;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// أيقونات السمة والإشعارات
          Row(
            children: [
              _buildIconButton(
                context,
                onTap: () => context.read<ThemeCubit>().toggleTheme(),
                assetPath: 'assets/images/moon.svg',
              ),
              const SizedBox(width: 8),
              _buildIconButton(
                context,
                onTap: () => context.pushNamed(AppRoutes.notificationScreen),
                assetPath: 'assets/images/notification.svg',
              ),
            ],
          ),

          /// العنوان
          Row(
            children: [
              AppText(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                text: title,
                fontSize: isSmallScreen ? 18 : 20,
                color: AppColors.primaryColor,
                textAlign: TextAlign.center,
              ),
              
              /// زر القائمة
              IconButton(
                onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
                icon: Icon(
                  Icons.menu_rounded,
                  size: isSmallScreen ? 22 : 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context,
      {required VoidCallback onTap, required String assetPath}) {
    bool isDarkMode =
        Theme.of(context).scaffoldBackgroundColor == const Color(0xff191201);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xff2b1e08) : Colors.white,
          shape: BoxShape.circle,
        ),
        height: 35,
        width: 35,
        child: AppImage(assetPath),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
