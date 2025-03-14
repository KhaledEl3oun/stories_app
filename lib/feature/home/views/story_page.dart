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

class StoryPage extends StatelessWidget {
  StoryPage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      body: SingleChildScrollView(
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
                     onTap: (){
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
                        onTap:() {
                          context.pushNamed(AppRoutes.notificationScreen);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          height: 40,
                          width: 40,
                          child: Image.asset('assets/images/notification.png'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AppText(
                        text: 'القصص',
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.primaryColor),
                      ),
                      const SizedBox(width: 10),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_forward))
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const CustomTextFieldSearch(),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 163 / 190,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      context.pushNamed(AppRoutes.storyDetailsPage);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor ==
                            Colors.black
                            ? Colors.grey[900]
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
                                    color:
                                    Theme.of(context).scaffoldBackgroundColor ==
                                        Colors.black
                                        ? Colors.grey[800]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    image: const DecorationImage(
                                      image:
                                      AssetImage('assets/images/Component 1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          const AppText(text: 'قصص عن الحيوانات',
                          textStyle: TextStyle(fontSize: 16),)
                          ,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )


            ],
          ),
        ),
      ),
    );
  }
}
