import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stories_app/core/network/dio_helper.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/route/route_generate.dart';
import 'package:stories_app/core/theme/app_themes.dart';
import 'package:stories_app/core/theme/cubit/theme_cubit.dart';
import 'package:stories_app/feature/auth/controller/auth_cubit.dart';
import 'package:stories_app/feature/favorite/controller/cubit/favorite_cubit.dart';
import 'package:stories_app/feature/home/controller/category_cubit.dart';
import 'package:stories_app/feature/home/controller/reed_un_reed_story_cubit.dart';
import 'package:stories_app/feature/home/controller/single_details_story_cubit.dart';
import 'package:stories_app/feature/home/controller/sub_category_cubit.dart';
import 'package:stories_app/feature/home/controller/sub_story_cubit.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // هذا يعمل عندما يكون التطبيق في الخلفية أو مغلق
  print(
      "📩 إشعار مستلم في الخلفية: ${message.notification?.title} - ${message.notification?.body}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();
  DioHelper.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit()..fetchCategoriesAndStories(),
        ),
        BlocProvider<SubCategoryCubit>(
          create: (context) => SubCategoryCubit(),
        ),  
        BlocProvider<DetailsStoryCubit>(
          create: (context) => DetailsStoryCubit(),
        ),
        BlocProvider<SubStoryCubit>(
          create: (context) => SubStoryCubit(),
        ),
        BlocProvider<ReedUnReedStoryCubit>(
          create: (context) => ReedUnReedStoryCubit(),
        ),
        BlocProvider<FavoriteCubit>(
          create: (context) => FavoriteCubit()..fetchGetAllFavorite(),
        ),
        //
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Stories',
              themeMode: themeMode,
              theme: AppThemes.light,
              darkTheme: AppThemes.dark,
              initialRoute: AppRoutes.splashScreen,
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          },
        );
      },
    );
  }
}
