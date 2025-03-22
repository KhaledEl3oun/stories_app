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
                              height: screenHeight * 0.18, // ✅ بدل `140`
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.categories.length,
                                itemBuilder: (context, index) {
                                  return CategoryItem(
                                    category: state.categories[index],
                                    onTap: () {
                                      context.pushNamed(AppRoutes.storyPage);
                                      context.read<SubCategoryCubit>().fetchSubCategories(state.categories[index].id);
                                    },
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
                            SizedBox(
                              height: screenHeight * 0.6, // ✅ بدل `630`
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(), // ✅ تعطيل الـ Scroll لأنه داخل `SingleChildScrollView`
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: screenWidth > 600 ? 3 : 2, // ✅ 3 أعمدة في الشاشات الكبيرة و 2 في الصغيرة
                                  crossAxisSpacing: screenWidth * 0.03,
                                  mainAxisSpacing: screenWidth * 0.03,
                                  childAspectRatio: 0.85, // ✅ تعديل حسب الحاجة
                                ),
                                itemCount: state.stories.length,
                                itemBuilder: (context, index) {
                                  final story = state.stories[index];
                                  return StoryItem(
                                    story: story,
                                    onTap: () {
                                      context.pushNamed(
                                        AppRoutes.storyDetailsPage,
                                        arguments: story,
                                      );
                                      context.read<DetailsStoryCubit>().fetchSingleStory(story.id);
                                    },
                                  );
                                },
                              ),
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
