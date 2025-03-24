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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor ==
                          Color(0xff191201)
                      ? Color(0xff2b1e08)
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
                height: 40,
                width: 40,
                child: AppImage('assets/images/moon.svg'),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                context.pushNamed(AppRoutes.notificationScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor ==
                          Color(0xff191201)
                      ? Color(0xff2b1e08)
                      : Colors.white,
                ),
                height: 40,
                width: 40,
                child: AppImage('assets/images/notification.svg'),
              ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            children: [
              AppText(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                text: title,
                fontSize: 20,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
                icon: const Icon(Icons.menu_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
