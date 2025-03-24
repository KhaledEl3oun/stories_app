import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/theme/cubit/theme_cubit.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/core/widget/text_failed/custom_textfailed%20_search.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';
import 'package:stories_app/feature/home/controller/sub_story_cubit.dart';
import '../../../core/widget/custom_app_image.dart';
import '../controller/sub_category_cubit.dart';

class StoryPage extends StatelessWidget {
  StoryPage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final subCategoryCubit = context.watch<SubCategoryCubit>();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
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
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).scaffoldBackgroundColor ==
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
                              color:
                                  Theme.of(context).scaffoldBackgroundColor ==
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
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
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
                  controller: subCategoryCubit.searchController,
                ),
                const SizedBox(height: 10),
                BlocBuilder<SubCategoryCubit, SubCategoryState>(
                  builder: (context, state) {
                    if (state is SubCategoryLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SubCategoryFailure) {
                      return Center(
                        child: AppText(
                          text: state.message,
                          textStyle: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    } else if (state is SubCategorySuccess) {
                      if (state.subCategories.isEmpty) {
                        return Center(
                          child: AppText(
                            text: 'لا يوجد بيانات',
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                          ),
                        );
                      }
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.subCategories.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 163 / 190,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    context.pushNamed(AppRoutes.subStoryPage);
                                    context.read<SubStoryCubit>().fetchSubStory(
                                          id: state.subCategories[index].id ??
                                              '',
                                        );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
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
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 133.h,
                                                width: 150.w,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                              .scaffoldBackgroundColor ==
                                                          Colors.black
                                                      ? Colors.grey[800]
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  image: DecorationImage(
                                                    image: NetworkImage(state
                                                            .subCategories[
                                                                index]
                                                            .image ??
                                                        ''),
                                                    fit: BoxFit.cover,
                                                    onError: (exception,
                                                        stackTrace) {
                                                      print(
                                                          "❌ فشل تحميل صورة الفئة: ${state.subCategories[index].image}");
                                                    },
                                                  ),
                                                ),
                                              ),
                                              AppText(
                                                text: state.subCategories[index]
                                                        .name ??
                                                    '',
                                                color: AppColors.primaryColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            if (subCategoryCubit.totalPages > 1)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: subCategoryCubit.currentPage > 1
                                        ? () {
                                            subCategoryCubit
                                                .fetchPreviousPage();
                                          }
                                        : null,
                                    icon: Icon(Icons.arrow_back_ios,
                                        color: AppColors.primaryColor),
                                  ),
                                  Text(
                                    "${subCategoryCubit.currentPage} من ${subCategoryCubit.totalPages}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primaryColor),
                                  ),
                                  IconButton(
                                    onPressed: subCategoryCubit.currentPage <
                                            subCategoryCubit.totalPages
                                        ? () {
                                            subCategoryCubit.fetchNextPage();
                                          }
                                        : null,
                                    icon: Icon(Icons.arrow_forward_ios,
                                        color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: AppText(
                          text: 'حدث خطأ ما',
                          textStyle: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
