import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/core/network/dio_helper.dart';
import 'package:stories_app/core/network/endpoints.dart';
import 'package:stories_app/feature/home/model/category_model.dart';
import 'package:stories_app/feature/home/model/story_model.dart';
import '../model/story_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());



  List<CategoryModel> categories = [];
  List<StoryModel> stories = [];

  Future<void> fetchCategoriesAndStories() async {
    emit(CategoryLoading());
    try {
      // ✅ تحميل الفئات
      final categoryResponse = await DioHelper.getData(url: Endpoints.category);
      print("✅ الفئات المستلمة من API: ${categoryResponse.data}");
      
      if (categoryResponse.statusCode == 200 && categoryResponse.data['data'] is List) {
        categories = (categoryResponse.data['data'] as List)
            .map((category) => CategoryModel.fromJson(category))
            .toList();
      } else {
        emit(CategoryFailure('❌ خطأ أثناء تحميل الفئات'));
        return;
      }

      // ✅ تحميل القصص
      final storyResponse = await DioHelper.getData(url: Endpoints.story);
      print("✅ القصص المستلمة من API: ${storyResponse.data}");
      
      if (storyResponse.statusCode == 200 && storyResponse.data['data'] is List) {
        stories = (storyResponse.data['data'] as List)
            .map((story) => StoryModel.fromJson(story))
            .toList();
      } else {
        emit(CategoryFailure('❌ خطأ أثناء تحميل القصص'));
        return;
      }

      // ✅ تحديث الحالة بعد تحميل البيانات
      emit(CategorySuccess(categories, stories));

    } catch (e) {
      print("❌ فشل الاتصال بالسيرفر: $e");
      emit(CategoryFailure("فشل الاتصال بالسيرفر"));
    }
  }
}
