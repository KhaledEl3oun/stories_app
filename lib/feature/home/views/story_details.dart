import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:photo_manager/photo_manager.dart';

import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/theme/cubit/theme_cubit.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';
import 'package:stories_app/feature/favorite/controller/cubit/favorite_cubit.dart';
import 'package:stories_app/feature/home/controller/single_details_category_cubit.dart';

import '../../../core/widget/Custom_app_image.dart';

class StoryDetailsPage extends StatelessWidget {
  StoryDetailsPage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      body: SingleChildScrollView(
        child:
            BlocBuilder<SingleDetailsCategoryCubit, SingleDetailsCategoryState>(
          builder: (context, state) {
            if (state is SingleDetailsCategoryLoading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (state is SingleDetailsCategorySuccess) {
              final singleCategory = state.singleCategory;
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
                                child: Image.asset(
                                    'assets/images/notification.png'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AppText(
                              text: singleCategory.name ?? '',
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
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppText(
                              text: 'تمت القراءة',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 16)),
                          Icon(
                            Icons.check_circle,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(singleCategory.image ?? ''),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {
                            print(
                                "❌ فشل تحميل صورة الفئة: ${singleCategory.image}");
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        // context
                        //     .read<SingleDetailsCategoryCubit>()
                        //     .saveImageToGallery(
                        //         'https://images.app.goo.gl/88BG62sPCmv3Bj7v9');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppText(
                              text: 'حفظ الى الهاتف',
                              textStyle: Theme.of(context).textTheme.bodyLarge),
                          SizedBox(width: 10),
                          AppImage('assets/images/import.svg',
                              height: 30, width: 30, fit: BoxFit.cover),
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
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          );
                        } else if (state is AddFavoriteFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: AppText(
                                text: state.message,
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<FavoriteCubit>()
                                .addFavorite(singleCategory.id ?? '');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AppText(
                                  text: 'اضافة الى المفضلة',
                                  textStyle:
                                      Theme.of(context).textTheme.bodyLarge),
                              SizedBox(width: 10),
                              AppImage('assets/images/Vector.svg',
                                  height: 30, width: 30, fit: BoxFit.cover),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (state is SingleDetailsCategoryFailure) {
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
    );
  }
}
