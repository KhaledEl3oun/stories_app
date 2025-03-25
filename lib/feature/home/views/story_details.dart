import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/theme/cubit/theme_cubit.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';
import 'package:stories_app/feature/favorite/controller/cubit/favorite_cubit.dart';
import 'package:stories_app/feature/home/controller/reed_un_reed_story_cubit.dart';
import 'package:stories_app/feature/home/controller/single_details_story_cubit.dart';
import 'package:stories_app/feature/home/views/ImagePreviewScreen.dart';

import '../../../core/widget/Custom_app_image.dart';

void downloadImages(String imageUrl, BuildContext context) async {
  // ✅ التحقق مما إذا كان المستخدم مسجل دخول أم لا
  User? user = FirebaseAuth.instance.currentUser;
  String? apiToken = GetStorage().read('token');
  if ((user == null || user.isAnonymous) && (apiToken ==null || apiToken.isEmpty) ){
    // ❌ المستخدم غير مسجل الدخول - عرض رسالة تحذير
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'يرجى تسجيل الدخول أولًا لحفظ الصورة!',
          style: TextStyle(color: Colors.white,
          fontFamily: 'ElMessiri'),
        ),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  // ✅ المستخدم مسجل دخول - السماح بتنزيل الصورة
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'يتم التحميل...',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ),
  );

  await FileDownloader.downloadFile(
    url: imageUrl,
    onDownloadError: (String error) {
      print('❌ خطأ في تحميل الصورة: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل تحميل الصورة'), backgroundColor: Colors.red),
      );
    },
    onDownloadCompleted: (String path) {
      print('✅ تم تحميل الصورة بنجاح: $path');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم الحفظ في الهاتف'), backgroundColor: Colors.green),
      );
    },
  );
}



class StoryDetailsPage extends StatelessWidget {
  
  StoryDetailsPage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
     final box = GetStorage();
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<DetailsStoryCubit, DetailsStoryState>(
                  builder: (context, state) {
                    if (state is DetailsStoryLoading) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(child: CircularProgressIndicator()),
                        ],
                      );
                    } else if (state is DetailsStorySuccess) {
                      final singleStory = state.singleCategory;
                      return AppPadding(
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
                                        context
                                            .read<ThemeCubit>()
                                            .toggleTheme();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                                      .scaffoldBackgroundColor ==
                                                  Color(0xff191201)
                                              ? Color(0xff2b1e08)
                                              : Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        height: 40,
                                        width: 40,
                                        child:
                                            AppImage('assets/images/moon.svg'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        context.pushNamed(
                                            AppRoutes.notificationScreen);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                                      .scaffoldBackgroundColor ==
                                                  Color(0xff191201)
                                              ? Color(0xff2b1e08)
                                              : Colors.white,
                                        ),
                                        height: 40,
                                        width: 40,
                                        child: AppImage(
                                            'assets/images/notification.svg'),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AppText(
                                      text: singleStory.title ?? '',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: AppColors.primaryColor),
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
                            const SizedBox(height: 10),
                            BlocConsumer<ReedUnReedStoryCubit,
                                ReedUnReedStoryState>(
                              listener: (context, state) {
                                if (state is ReedUnReedStorySuccess) {
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.pushReplacementNamed(
                                        context, AppRoutes.homeScreen);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: AppText(
                                        text: 'تمت العمليه',
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  );
                                } else if (state is ReedUnReedStoryFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: AppText(
                                        text: state.error,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: () {
                                    if (singleStory.isRead == false) {
                                      context
                                          .read<ReedUnReedStoryCubit>()
                                          .markStoryAsRead(
                                              singleStory.id ?? '');
                                    } else {
                                      context
                                          .read<ReedUnReedStoryCubit>()
                                          .markStoryUnRead(
                                              singleStory.id ?? '');
                                    }
                                    if (state is ReedUnReedStorySuccess) {
                                      Future.delayed(Duration(seconds: 3), () {
                                        context.pushReplacementNamed(
                                            AppRoutes.homeScreen);
                                      });
                                    }
                                  },
                                  child: state is ReedUnReedStoryLoading
                                      ? CircularProgressIndicator()
                                      : Container(
                                          padding: const EdgeInsets.all(5),
                                          width: 120,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color:
                                                      singleStory.isRead == true
                                                          ? Colors.green
                                                          : Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              AppText(
                                                  text: 'تمت القراءة',
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          fontSize: 16,
                                                          color: singleStory
                                                                      .isRead ==
                                                                  true
                                                              ? Colors.green
                                                              : Colors.grey)),
                                              Icon(
                                                Icons.check_circle,
                                                color:
                                                    singleStory.isRead == true
                                                        ? Colors.green
                                                        : Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                 Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                    builder: (_) => ImagePreviewScreen(imageUrl: singleStory.imageCover ?? ''),
                                        ),
    );
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.5,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        singleStory.imageCover ?? ''),
                                    fit: BoxFit.fill,
                                    onError: (exception, stackTrace) {
                                      print(
                                          "❌ فشل تحميل صورة الفئة: ${singleStory.imageCover}");
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                                if (singleStory.imageCover != null) {
                               downloadImages(singleStory.imageCover ?? '', context);
                                }
                              
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AppText(
                                      text: 'حفظ الى الهاتف',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  SizedBox(width: 10),
                                  AppImage('assets/images/import.svg',
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.cover),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            BlocConsumer<FavoriteCubit, FavoriteState>(
                              listener: (context, state) {
                                if (state is AddFavoriteSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: AppText(
                                        text: 'تمت الاضافة الى المفضلة',
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  );
                                } else if (state is AddFavoriteFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: AppText(
                                        text: state.message,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: () {
                                     String? apiToken = box.read('token'); 
                                      User? user = FirebaseAuth.instance.currentUser;
  
                                    if ((user == null || user.isAnonymous) && (apiToken == null || apiToken.isEmpty)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                content: Text(
          'يرجى تسجيل الدخول أولًا لإضافة القصة إلى المفضلة!',
          style: TextStyle( 
            fontFamily: 'ElMessiri',
            color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  // ✅ المستخدم مسجل دخول - السماح بالإضافة
  context.read<FavoriteCubit>().addFavorite(singleStory.id ?? '');
},

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AppText(
                                          text: 'اضافة الى المفضلة',
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      SizedBox(width: 10),
                                      AppImage('assets/images/Vector.svg',
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.cover),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    } else if (state is DetailsStoryFailure) {
                      return Center(
                        child: AppText(
                          text: state.message,
                          textStyle: Theme.of(context).textTheme.bodyLarge,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
