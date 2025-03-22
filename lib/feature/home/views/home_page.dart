import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/shared.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/custom_app_image.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/core/widget/text_failed/custom_textfailed%20_search.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';
import 'package:stories_app/feature/home/controller/category_cubit.dart';
import 'package:stories_app/feature/home/controller/sub_category_cubit.dart';
import 'package:stories_app/feature/home/views/widget/CategoryItem.dart';
import 'package:stories_app/feature/home/views/widget/StoryItem.dart';
import 'package:stories_app/feature/home/views/widget/custom_row_header.dart';

import '../controller/single_details_story_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    //String? userName = box.read('userName') ?? '';
    String userName = currentUser?.userName ?? '';
    final categoryCubit = context.watch<CategoryCubit>();

    // ✅ جلب أبعاد الشاشة
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer:  CustomDrawer(),
        body: SingleChildScrollView(
          child: AppPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: screenHeight * 0.05), // ✅ بدل `50`
                AppBarCustom(
                  title: ' $userName مرحبا بك',
                  scaffoldKey: _scaffoldKey,
                ),
                SizedBox(height: screenHeight * 0.02), // ✅ بدل `20`
                CustomTextFieldSearch(
                  hintText: 'ابحث هنا',
                  suffixIcon: AppImage(
                    'assets/images/search-normal.svg',
                    width: screenWidth * 0.07, // ✅ بدل `30`
                    height: screenWidth * 0.07,
                  ),
                  controller: categoryCubit.searchController,
                ),
                SizedBox(height: screenHeight * 0.02),
                AppText(
                  text: 'الأقسام',
                  fontSize: screenWidth * 0.05, // ✅ بدل `20`
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: screenHeight * 0.02),

                // ✅ عرض الأقسام بشكل Responsive
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading && context.read<CategoryCubit>().stories.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CategoryFailure) {
                      return Center(
                        child: AppText(
                          text: state.message,
                          textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.primaryColor,
                              ),
                        ),
                      );
                    } else if (state is CategorySuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.categories.isEmpty)
                            const Center(child: Text("❌ لا توجد أقسام"))
                          else
                            SizedBox(
                              height:
                                  140, // ✅ تأكد من تحديد ارتفاع لـ `ListView`
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.categories.length,
                                itemBuilder: (context, index) {
                                  final category = state.categories[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        context.pushNamed(
                                          AppRoutes.storyPage,
                                        );
                                        context
                                            .read<SubCategoryCubit>()
                                            .fetchSubCategories(category.id);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        width: 130, // ✅ تأكد من تحديد عرض مناسب
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                                      .scaffoldBackgroundColor ==
                                                  Color(0xff191201)
                                              ? Color(0xff2b1e08)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 90.h,
                                              width: 120.w,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                            .scaffoldBackgroundColor ==
                                                        Color(0xff191201)
                                                    ? Colors.grey[800]
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(9),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      category.image),
                                                  fit: BoxFit.cover,
                                                  onError:
                                                      (exception, stackTrace) {
                                                    print(
                                                        "❌ فشل تحميل صورة الفئة: ${category.image}");
                                                  },
                                                ),
                                              ),
                                            ),
                                            Gap(7.h),
                                            Center(
                                              child: Text(category.name,
                                                  style: TextStyle(
                                                    fontFamily: 'cairo',
                                                    color: Theme.of(context)
                                                                .scaffoldBackgroundColor ==
                                                            Color(0xff191201)
                                                        ? AppColors.white
                                                        : Colors.black,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          SizedBox(height: screenHeight * 0.03),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "أحدث المنشورات",
                              style: TextStyle(
                                fontFamily: 'cairo',
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          // ✅ عرض القصص بشكل Responsive
                          if (state.stories.isEmpty)
                            const Center(child: Text("❌ لا توجد قصص"))
                          else
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.stories.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 163 / 190,
                              ),
                              itemBuilder: (context, index) {
                                final story = state.stories[index];
                                return GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      AppRoutes.storyDetailsPage,
                                      arguments: story,
                                    );
                                    context
                                        .read<DetailsStoryCubit>()
                                        .fetchSingleStory(story.id);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: 290.h,
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
                                        Container(
                                          height: 140.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                        .scaffoldBackgroundColor ==
                                                    Colors.black
                                                ? Color(0xff2b1e08)
                                                : Colors.white,
                                            borderRadius: const BorderRadius
                                                .only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                                bottomLeft: Radius.circular(16),
                                                bottomRight:
                                                    Radius.circular(16)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  story.imageCover),
                                              fit: BoxFit.cover,
                                              onError: (exception, stackTrace) {
                                                print(
                                                    "❌ فشل تحميل صورة القصة: ${story.imageCover}");
                                              },
                                            ),
                                          ),
                                        ),
                                        Gap(5.h),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              story.title,
                                              style: TextStyle(
                                                fontFamily: "cairo",
                                                color: Theme.of(context)
                                                            .scaffoldBackgroundColor ==
                                                        Color(0xff191201)
                                                    ? AppColors.white
                                                    : Colors.black,
                                                fontSize: 14.dg,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Gap(5.h),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      );
                    }
                    return const Center(child: Text("❌ لا توجد بيانات متاحة"));
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
