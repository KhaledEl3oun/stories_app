class Endpoints {
  static const String login = '/api/v1/auth/login';
  static const String register = '/api/v1/auth/signup';
  static const String forgetPassword = '/api/v1/auth/forgetPassword';
  static const String verifyResetCode = '/api/v1/auth/verifyResetCode';
  static const String resetPassword = '/api/v1/auth/resetPassword';
  static const String category = '/api/v1/categories';
  static const String getAllfavorite = '/api/v1/favouriteList';
  static const String addfavorite = '/api/v1/favouriteList';
  static String subCategory(String id) {
    return '/api/v1/categories/$id/subcategories';
  }

  static String singleCategory(String id) {
    return '/api/v1/subCategories/$id';
  }

  static const String story = '/api/v1/story?sort=latest';
}
