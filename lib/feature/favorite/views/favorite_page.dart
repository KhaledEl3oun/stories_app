import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/theme/cubit/theme_cubit.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/core/widget/text_failed/custom_textfailed%20_search.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';

import '../../../core/widget/custom_app_image.dart';
import '../controller/cubit/favorite_cubit.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.watch<FavoriteCubit>();
    return Scaffold(
      key: scaffoldKey,
      endDrawer: CustomDrawer(),
      body: 
      
      Container(
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Theme.of(context).scaffoldBackgroundColor == const Color(0xff191201)
                  ? 'assets/images/darkBg.png' // ✅ خلفية الدارك
                  : 'assets/images/lightBg.png', // ✅ خلفية اللايت
            ),
            fit: BoxFit.cover, // ✅ جعل الصورة تغطي الشاشة بالكامل
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<FavoriteCubit>().fetchGetAllFavorite();
                },
                child: SingleChildScrollView(
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
                                GestureDetector(
                                  onTap: () {
                                    context.read<ThemeCubit>().toggleTheme();
                                  },
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: Theme.of(context)
                                                                .scaffoldBackgroundColor ==
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
                                    decoration:  BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                                                .scaffoldBackgroundColor ==
                                                            Color(0xff191201)
                                                        ? Color(0xff2b1e08)
                                                        : Colors.white,
                                    ),
                                    height: 40,
                                    width: 40,
                                    child:
                                        AppImage('assets/images/notification.svg'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AppText(
                                  text: 'المفضله',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: AppColors.primaryColor),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                    onPressed: () {
                                      scaffoldKey.currentState?.openEndDrawer();
                                    },
                                    icon: const Icon(Icons.menu_rounded)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomTextFieldSearch(
                          hintText: 'ابحث هنا',
                          suffixIcon: AppImage(
                            'assets/images/search-normal.svg',
                            width: 30,
                            height: 30,
                          ),
                          controller: favoriteCubit.searchController,
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<FavoriteCubit, FavoriteState>(
                          builder: (context, state) {
                            if (state is FavoriteLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is FavoriteSuccess) {
                              final getAllFavoriteModel = state.getAllFavoriteModel;
                              return getAllFavoriteModel.isEmpty
                                  ? Center(
                                      child: AppText(
                                        text: 'قائمه المفضله فارغه',
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: AppColors.primaryColor),
                                      ),
                                    )
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: getAllFavoriteModel.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 163 / 190,
                                      ),
                                      itemBuilder: (context, index) {
                                        final getAllFavoriteIndex =
                                            getAllFavoriteModel[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                            color:Theme.of(context)
                                               .scaffoldBackgroundColor ==
                                             Color(0xff191201)
                                                        ? Color(0xff2b1e08)
                                                        : Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 140,
                                                  width: 160,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Theme.of(context).brightness ==
                                                                Brightness.dark
                                                            ? Colors.grey[800]
                                                            : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(16),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          getAllFavoriteIndex
                                                                  .imageCover ??
                                                              ''),
                                                      fit: BoxFit.cover,
                                                      onError: (exception, stackTrace) {
                                                        print(
                                                            "❌ فشل تحميل صورة الفئة: ${getAllFavoriteIndex.imageCover}");
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: AppText(
                                                        text:
                                                            getAllFavoriteIndex.title ??
                                                                '',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        textStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                color: AppColors
                                                                    .primaryColor)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(
                                                    Icons.favorite,
                                                    color: AppColors.primaryColor,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                            } else if (state is FavoriteFailure) {
                              return Center(
                                child: AppText(
                                  text: state.message,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: AppColors.primaryColor),
                                ),
                              );
                            } else {
                              return AppText(
                                text: '''لم يتم تحميل البيانات''',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: AppColors.primaryColor),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
