
import 'package:get_storage/get_storage.dart';
import 'caching_keys.dart';

class PreferenceManager {

  /// ::::::::::::::: Dark Mode :::::::::::::://
  void saveIsDarkMode(bool isDark) => GetStorage().write(CachingKey.settings.isDarkMode, isDark);

   bool isDarkMode() => GetStorage().read(CachingKey.settings.isDarkMode) as bool? ?? false;

  /// ::::::::::::::: Logged In :::::::::::::://
  void saveIsLoggedIn(bool isLoggedIn) =>
      GetStorage().write(CachingKey.user.isLoggedIn, isLoggedIn);

  bool isLoggedIn() =>
      GetStorage().read(CachingKey.user.isLoggedIn) as bool? ?? false;

  /// ::::::::::::::: Language :::::::::::::://
  void saveLanguage(String lang) =>
      GetStorage().write(CachingKey.settings.language, lang);

  String currentLang() =>
      GetStorage().read(CachingKey.settings.language) as String? ?? 'en';

  /// ::::::::::::::: User Id :::::::::::::://
  void saveUserId(String userId) => GetStorage().write(CachingKey.user.userId, userId);

  String currentUserId() =>
      GetStorage().read(CachingKey.user.userId) as String? ?? '';

  /// ::::::::::::::: FCM Token :::::::::::::://
  void saveFcmToken(String userName) =>
      GetStorage().write(CachingKey.fcm.token, userName);

  String getFcmToken() =>
      GetStorage().read(CachingKey.fcm.token) as String? ?? '';

   /// ::::::::::::::: User Model :::::::::::::://
  void saveUserModel(Map<String, dynamic> json) =>
       GetStorage().write(CachingKey.user.userModel, json);








}
