import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/core/network/dio_helper.dart';
import 'package:stories_app/core/network/endpoints.dart';
import 'package:stories_app/core/theme/themes.dart';
import 'package:stories_app/feature/home/model/category_model.dart';
import 'package:stories_app/feature/home/model/story_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial()) {
    searchController.addListener(_onSearchTextChanged);
  }

  List<CategoryModel> categories = [];
  List<StoryModel> stories = [];
  TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;

  void _onSearchTextChanged() {
    isSearchActive = searchController.text.isNotEmpty;
    emit(CategorySearchStateChanged(isSearchActive));

    // ✅ استدعاء البحث مباشرة عند الكتابة
    fetchCategoriesAndStories();
  }

  Future<void> fetchCategoriesAndStories() async {
    emit(CategoryLoading());
    try {
      final categoryResponse = await DioHelper.getData(
          url: Endpoints.category, query: {'search': searchController.text});

      if (categoryResponse.statusCode == 200 &&
          categoryResponse.data['data'] is List) {
        categories = (categoryResponse.data['data'] as List)
            .map((category) => CategoryModel.fromJson(category))
            .toList();
      } else {
        emit(CategoryFailure('❌ خطأ أثناء تحميل الفئات'));
        return;
      }

      final storyResponse = await DioHelper.getData(
          url: Endpoints.story, query: {'search': searchController.text});

      if (storyResponse.statusCode == 200 &&
          storyResponse.data['data'] is List) {
        stories = (storyResponse.data['data'] as List)
            .map((story) => StoryModel.fromJson(story))
            .toList();
      } else {
        emit(CategoryFailure('❌ خطأ أثناء تحميل القصص'));
        return;
      }

      emit(CategorySuccess(categories, stories));
    } catch (e) {
      emit(CategoryFailure("فشل الاتصال بالسيرفر"));
    }
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
