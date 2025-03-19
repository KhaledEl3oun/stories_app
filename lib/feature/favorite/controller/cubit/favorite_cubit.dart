import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:stories_app/core/theme/themes.dart';
import 'package:stories_app/feature/favorite/model/add_favorite_model.dart';
import 'package:stories_app/feature/favorite/model/get_all_favorite_model.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/endpoints.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial()) {
    searchController.addListener(_onSearchTextChanged);
  }

  List<GetAllFavoriteModel> getAllFavorite = [];
  bool isSearchActive = false;
  TextEditingController searchController = TextEditingController();
  void _onSearchTextChanged() {
    isSearchActive = searchController.text.isNotEmpty;
    emit(SearchStateChanged(isSearchActive));

    // ✅ استدعاء البحث مباشرة عند الكتابة
    fetchGetAllFavorite();
  }

  Future<void> fetchGetAllFavorite() async {
    emit(FavoriteLoading());
    try {
      // ✅ تحميل الفئات
      final getAllFavoriteResponse = await DioHelper.getData(
          url: Endpoints.getAllfavorite,
          query: {'search': searchController.text},
          headers: {'Authorization': 'Bearer ${GetStorage().read('token')}'});
      print("✅ الفئات المستلمة من API: ${getAllFavoriteResponse.data}");

      if (getAllFavoriteResponse.statusCode == 200 &&
          getAllFavoriteResponse.data['data'] is List) {
        getAllFavorite = (getAllFavoriteResponse.data['data'] as List)
            .map((getAllFavorite) =>
                GetAllFavoriteModel.fromJson(getAllFavorite))
            .toList();
      } else {
        emit(FavoriteFailure('❌ خطأ أثناء تحميل الفئات'));
        return;
      }
      emit(FavoriteSuccess(getAllFavorite));
    } catch (e) {
      print("❌ فشل الاتصال بالسيرفر: $e");
      emit(FavoriteFailure("فشل الاتصال بالسيرفر"));
    }
  }

  Future<void> addFavorite(String storyId) async {
    emit(AddFavoriteLoading());
    try {
      final response = await DioHelper.postData(
        url: Endpoints.addfavorite, // الـ endpoint الخاص بيها
        data: {'storyId': storyId},
        headers: {'Authorization': 'Bearer ${GetStorage().read('token')}'},
      );

      if (response.statusCode == 200) {
        final messageModel = AddFavoriteModel.fromJson(response.data);
        debugPrint("✅ تمت الاضافه الي المفضله: ${messageModel.message}");
        emit(AddFavoriteSuccess(messageModel));
      } else {
        emit(AddFavoriteFailure("لم يتم الاضافه الي المفضله"));
      }
    } catch (error) {
      emit(AddFavoriteFailure("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا."));
      debugPrint("❌ خطأ غير متوقع: $error");
    }
  }
}
