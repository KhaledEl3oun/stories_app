class CachingKey {
  static var fcm = _FCMKeys();
  static var  user = _UserKeys();
  static var  settings = _SettingsKeys();
}

class _FCMKeys {
  final String token = 'FCM_TOKEN';
}

class _UserKeys {
  final String isLoggedIn = 'IS_LOGGED_IN';
  final String userModel = 'USER_MODEL';
  final String userId = 'USER_ID';
}

class _SettingsKeys {
  final String language = 'LANGUAGE';
  final String isDarkMode = 'IS_DARK_MODE';
}
