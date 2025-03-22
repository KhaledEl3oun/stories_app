import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stories_app/core/widget/custom_app_image.dart';
import 'package:stories_app/feature/home/controller/category_cubit.dart';
import 'package:stories_app/feature/home/controller/sub_category_cubit.dart';

import '../controller/single_details_story_cubit.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getDeviceToken();
    setupFirebaseMessagingListener();
    requestNotificationPermission();
  }

  void getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print("📲 Device Token: $token");
      } else {
        print("❌ لم يتم الحصول على Device Token");
      }
    } catch (e) {
      print("❌ خطأ أثناء الحصول على Device Token: $e");
    }
  }

  void setupFirebaseMessagingListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "📩 إشعار مستلم أثناء تشغيل التطبيق: ${message.notification?.title} - ${message.notification?.body}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "${message.notification?.title} - ${message.notification?.body}"),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  void requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ تم منح صلاحيات الإشعارات");
    } else {
      print("❌ رفض المستخدم منح الصلاحيات");
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? userName = box.read('userName') ?? '';
    final categoryCubit = context.watch<CategoryCubit>(); // ✅ يراقب التغييرات

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: CustomDrawer(),
        body: SingleChildScrollView(
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
                          Gap(2.h),

                          // ✅ عرض القصص (أحدث المنشورات)
                          if (state.stories.isEmpty)
                            const Center(child: Text("❌ لا توجد قصص "))
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
