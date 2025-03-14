import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/resource/app_images.dart';
import 'package:stories_app/core/route/app_routes.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

void checkLoginStatus(BuildContext context) async {
  final box = GetStorage();
  String? token = box.read('token');

  print("🟢 التوكن المخزن: $token"); // ✅ طباعة التوكن لمعرفة حالته

  if (token != null && token.isNotEmpty) {
    print("✅ المستخدم مسجّل دخول، سيتم التوجيه إلى `HomeScreen`");
    Future.delayed(Duration(milliseconds: 500), () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/homeScreen'); // ✅ تأكد أن اسم المسار صحيح
      }
    });
  } else {
    print("❌ لم يتم العثور على `token`، سيتم التوجيه إلى `LoginScreen`");
    Future.delayed(Duration(milliseconds: 500), () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/loginScreen'); // ✅ تأكد أن اسم المسار صحيح
      }
    });
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      checkLoginStatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.splashBackground,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              AppImages.logo,
              width: 350,
              height: 350,
            ),
          ),
        ],
      ),
    );
  }
}
