import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stories_app/core/theme/themes.dart';

import '../../../core/network/dio_helper.dart';
import '../../../core/network/endpoints.dart';
import '../model/sub_category_model.dart';

part 'sub_category_state.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  SubCategoryCubit() : super(SubCategoryInitial()) {
    searchController.addListener(_onSearchTextChanged);
  }
  List<SubCategoryModel> subCategories = [];
  TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;
  String idc = '';
  void _onSearchTextChanged() {
    isSearchActive = searchController.text.isNotEmpty;
    emit(SearchStateChanged(isSearchActive));

    // ✅ استدعاء البحث مباشرة عند الكتابة
    fetchSubCategories(idc);
  }

  Future<void> fetchSubCategories(String id) async {
    emit(SubCategoryLoading());
    try {
      // ✅ تحميل الفئات
      final subcategoryResponse = await DioHelper.getData(
          url: Endpoints.subCategory(id),
          query: {'search': searchController.text});
      print("✅ الفئات المستلمة من API: ${subcategoryResponse.data}");

      if (subcategoryResponse.statusCode == 200 &&
          subcategoryResponse.data['data'] is List) {
        subCategories = (subcategoryResponse.data['data'] as List)
            .map((subcategory) => SubCategoryModel.fromJson(subcategory))
            .toList();
        idc = id;
      } else {
        emit(SubCategoryFailure('❌ خطأ أثناء تحميل الفئات'));
        return;
      }
      emit(SubCategorySuccess(subCategories));
    } catch (e) {
      print("❌ فشل الاتصال بالسيرفر: $e");
      emit(SubCategoryFailure("فشل الاتصال بالسيرفر"));
    }
  }
}
