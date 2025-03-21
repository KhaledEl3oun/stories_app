import 'package:flutter/material.dart';
import 'package:stories_app/feature/auth/view/change_password_page.dart';
import 'package:stories_app/feature/auth/view/complate_page.dart';
import 'package:stories_app/feature/auth/view/forget_password_page.dart';
import 'package:stories_app/feature/auth/view/login_page.dart';
import 'package:stories_app/feature/auth/view/register_page.dart';
import 'package:stories_app/feature/auth/view/verification_page.dart';
import 'package:stories_app/feature/favorite/views/favorite_page.dart';
import 'package:stories_app/feature/drawer/screen/my_acount.dart';
import 'package:stories_app/feature/drawer/screen/privacy_policy_page.dart';
import 'package:stories_app/feature/drawer/screen/rate_app_page.dart';
import 'package:stories_app/feature/drawer/screen/support_page.dart';
import 'package:stories_app/feature/drawer/screen/update_email.dart';
import 'package:stories_app/feature/drawer/screen/update_name.dart';
import 'package:stories_app/feature/drawer/screen/update_password.dart';
import 'package:stories_app/feature/drawer/screen/update_phone.dart';
import 'package:stories_app/feature/home/views/home_page.dart';
import 'package:stories_app/feature/home/views/story_page.dart';
import 'package:stories_app/feature/home/views/story_details.dart';
import 'package:stories_app/feature/notification/views/notification_page.dart';
import 'package:stories_app/feature/on_boarding/on_boarding_page.dart';
import 'package:stories_app/feature/on_boarding/on_boarding_page2.dart';
import 'package:stories_app/feature/splash/splash_page.dart';
import '../../feature/home/views/sub_story_page.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case AppRoutes.onBoardingScreen1:
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      case AppRoutes.onBoardingScreen2:
        return MaterialPageRoute(builder: (_) => const OnBoardingPage2());
      case AppRoutes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case AppRoutes.forgetPasswordPage:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordPage());
      case AppRoutes.verificationPage:
        final args = settings.arguments as Map<String, dynamic>?;
        final email = args?["email"] ?? "";
        return MaterialPageRoute(
            builder: (_) => VerificationPage(email: email));
      case AppRoutes.changePasswordPage:
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
      case AppRoutes.complatePage:
        return MaterialPageRoute(builder: (_) => const ComplatePage());
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutes.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case AppRoutes.myAccount:
        return MaterialPageRoute(builder: (_) => MyAccount());
      case AppRoutes.updateName:
        return MaterialPageRoute(builder: (_) => UpdateName());
      case AppRoutes.updateEmail:
        return MaterialPageRoute(builder: (_) => UpdateEmail());
      case AppRoutes.updatePhone:
        return MaterialPageRoute(builder: (_) => UpdatePhone());
      case AppRoutes.updatePassword:
        return MaterialPageRoute(builder: (_) => UpdatePassword());
      case AppRoutes.favoriteScreen:
        return MaterialPageRoute(builder: (_) => FavoritePage());
      case AppRoutes.supportPage:
        return MaterialPageRoute(builder: (_) => SupportPage());
      case AppRoutes.rateAppPage:
        return MaterialPageRoute(builder: (_) => RateAppPage());
      case AppRoutes.privacyPolicyPage:
        return MaterialPageRoute(builder: (_) => PrivacyPolicyPage());
      case AppRoutes.storyPage:
        return MaterialPageRoute(builder: (_) => StoryPage());
      case AppRoutes.subStoryPage:
        return MaterialPageRoute(builder: (_) => SubStoryPage());
      case AppRoutes.storyDetailsPage:
        return MaterialPageRoute(builder: (_) => StoryDetailsPage());
      default:
        return _unDefinedRoute();
    }
  }

  static Route<dynamic> _unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text('This route is not defined')),
      ),
    );
  }
}
