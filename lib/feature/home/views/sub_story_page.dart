import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/cubit/theme_cubit.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/core/widget/text_failed/custom_textfailed%20_search.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';
import 'package:stories_app/feature/home/controller/single_details_story_cubit.dart';
import 'package:stories_app/feature/home/controller/sub_story_cubit.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widget/custom_app_image.dart';

class SubStoryPage extends StatelessWidget {
  SubStoryPage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final subStoryCubit = context.watch<SubStoryCubit>();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Container(
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
                                  child: AppImage('assets/images/notification.svg'),
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
                        controller: subStoryCubit.searchController,
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<SubStoryCubit, SubStoryState>(
                        builder: (context, state) {
                          if (state is SubStoryLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is SubStoryFailure) {
                            return Center(
                              child: AppText(
                                text: state.message,
                                textStyle: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          } else if (state is SubStorySuccess) {
                            if (state.subStoryModel.isEmpty) {
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
                                    itemCount: state.subStoryModel.length,
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
                                          context
                                              .pushNamed(AppRoutes.storyDetailsPage);
                                          context
                                              .read<DetailsStoryCubit>()
                                              .fetchSingleStory(
                                                state.subStoryModel[index].id ?? '',
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
                                                                  .subStoryModel[
                                                                      index]
                                                                  .imageCover ??
                                                              ''),
                                                          fit: BoxFit.cover,
                                                          onError: (exception,
                                                              stackTrace) {
                                                            print(
                                                                "❌ فشل تحميل صورة الفئة: ${state.subStoryModel[index].imageCover}");
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        if (state.subStoryModel[index]
                                                                .isRead ==
                                                            true)
                                                          Icon(
                                                            Icons.check_circle,
                                                            color: Colors.green,
                                                          ),
                                                        Expanded(
                                                          child: AppText(
                                                            textAlign:
                                                                TextAlign.center,
                                                            overflow:
                                                                TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                            text: state
                                                                    .subStoryModel[
                                                                        index]
                                                                    .title ??
                                                                '',
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                  color: Theme.of(context)
                                                                              .scaffoldBackgroundColor ==
                                                                          Colors.black
                                                                      ? Colors.white
                                                                      : Colors.black,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
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
                                  if (subStoryCubit.totalPages > 1)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: subStoryCubit.currentPage > 1
                                              ? () {
                                                  subStoryCubit.fetchPreviousPage();
                                                }
                                              : null,
                                          icon: Icon(Icons.arrow_back_ios,
                                              color: AppColors.primaryColor),
                                        ),
                                        Text(
                                          "${subStoryCubit.currentPage} من ${subStoryCubit.totalPages}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.primaryColor),
                                        ),
                                        IconButton(
                                          onPressed: subStoryCubit.currentPage <
                                                  subStoryCubit.totalPages
                                              ? () {
                                                  subStoryCubit.fetchNextPage();
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
          ),
        ],
      ),
    );
  }
}
