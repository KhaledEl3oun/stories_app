import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stories_app/core/widget/custom_app_image.dart';
import 'package:stories_app/core/widget/text_failed/custom_textfailed%20_search.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';
import 'package:stories_app/feature/home/controller/category_cubit.dart';
import 'package:stories_app/feature/home/controller/sub_category_cubit.dart';
import 'package:stories_app/feature/home/views/widget/custom_row_header.dart';
import 'package:stories_app/feature/on_boarding/on_boarding.dart';

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
    String? userName = box.read('userName') ?? '';
    final categoryCubit = context.watch<CategoryCubit>(); // ✅ يراقب التغييرات
    final category1Cubit = context.read<SubCategoryCubit>();
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: CustomDrawer(),
        body: SingleChildScrollView(
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
            child: AppPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 50),
                  AppBarCustom(
                    title: ' $userNameمرحبا بك',
                    scaffoldKey: _scaffoldKey,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFieldSearch(
                    hintText: 'ابحث هنا',
                    suffixIcon: AppImage(
                      'assets/images/search-normal.svg',
                      width: 30,
                      height: 30,
                    ),
                    controller: categoryCubit.searchController,
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 120.h,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/Component 1.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppText(
                    text: 'الأقسام',
                    fontSize: 20,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CategoryFailure) {
                        return Center(
                          child: AppText(
                            text: state.message,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.primaryColor),
                          ),
                        );
                      } else if (state is CategorySuccess) {
                        print(
                            "🟢 الفئات في BlocBuilder: ${state.categories.map((c) => c.name).toList()}"); // ✅ طباعة الفئات داخل `BlocBuilder`

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ✅ عرض الفئات (الأقسام)
                            if (state.categories.isEmpty)
                              const Center(child: Text("❌لا توجد أقسام "))
                            else
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: SizedBox(
                                  height:
                                      140, // ✅ تأكد من تحديد ارتفاع لـ `ListView`
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.categories.length,
                                    itemBuilder: (context, index) {
                                      final category = state.categories[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            context.pushNamed(
                                              AppRoutes.storyPage,
                                            );
                                            context
                                                .read<SubCategoryCubit>()
                                                .fetchSubCategories(
                                                    id: category.id);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            width: 130,
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
                                                        BorderRadius.circular(
                                                            9),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          category.image),
                                                      fit: BoxFit.cover,
                                                      onError: (exception,
                                                          stackTrace) {
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
                                                                Color(
                                                                    0xff191201)
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
                              ),

                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "أحدث المنشورات",
                                style: TextStyle(
                                    fontFamily: 'cairo',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor),
                              ),
                            ),
                            Gap(1.h),

                            // ✅ عرض القصص (أحدث المنشورات)
                            if (state.stories.isEmpty)
                              const Center(child: Text("❌ لا توجد قصص "))
                            else
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: GridView.builder(
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
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(16),
                                                        topRight:
                                                            Radius.circular(16),
                                                        bottomLeft:
                                                            Radius.circular(16),
                                                        bottomRight:
                                                            Radius.circular(
                                                                16)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      story.imageCover),
                                                  fit: BoxFit.cover,
                                                  onError:
                                                      (exception, stackTrace) {
                                                    print(
                                                        "❌ فشل تحميل صورة القصة: ${story.imageCover}");
                                                  },
                                                ),
                                              ),
                                            ),
                                            Gap(5.h),
                                            Expanded(
                                              child: Column(
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Gap(5.h),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            if (category1Cubit.totalPages > 1)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: category1Cubit.currentPage > 1
                                        ? () {
                                            category1Cubit.fetchPreviousPage();
                                          }
                                        : null,
                                    icon: Icon(Icons.arrow_back_ios,
                                        color: AppColors.primaryColor),
                                  ),
                                  Text(
                                    "${category1Cubit.currentPage} من ${category1Cubit.totalPages}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primaryColor),
                                  ),
                                  IconButton(
                                    onPressed: category1Cubit.currentPage <
                                            category1Cubit.totalPages
                                        ? () {
                                            category1Cubit.fetchNextPage();
                                          }
                                        : null,
                                    icon: Icon(Icons.arrow_forward_ios,
                                        color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                          ],
                        );
                      }

                      return const Center(
                          child: Text("❌ لا توجد بيانات متاحة"));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
