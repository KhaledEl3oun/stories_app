import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.watch<FavoriteCubit>();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      body: RefreshIndicator(
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
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            height: 40,
                            width: 40,
                            child: Image.asset('assets/images/moon.png'),
                          ),
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
                          text: 'المفضله',
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
                                    color: Theme.of(context)
                                                .scaffoldBackgroundColor ==
                                            Colors.black
                                        ? Colors.grey[900]
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
    );
  }
}
