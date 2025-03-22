class Endpoints {
  static const String login = '/api/v1/auth/login';
  static const String rating = '/api/v1/rating';
  static const String register = '/api/v1/auth/signup';
  static const String forgetPassword = '/api/v1/auth/forgetPassword';
  static const String verifyResetCode = '/api/v1/auth/verifyResetCode';
  static const String resetPassword = '/api/v1/auth/resetPassword';
  static const String category = '/api/v1/categories';
  static const String getAllfavorite = '/api/v1/favouriteList';
  static const String addfavorite = '/api/v1/favouriteList';
  static const String changeMyPasswordAccount =
      '/api/v1/user/changeMyPasswordAccount';
  static String subCategory(String id) {
    return '/api/v1/categories/$id/subcategories';
  }

  static String markStoryAsRead(String id) {
    return '/api/v1/story/$id/mark-as-read';
  }

  static String markStoryUnRead(String id) {
    return '/api/v1/story/$id/unmark-as-read';
  }

  static String substory(String id) {
    return '/api/v1/subCategories/$id/stories';
  }

  static String singleStory(String id) {
    return '/api/v1/story/$id';
  }

  static const String story = '/api/v1/story?sort=latest';
}
