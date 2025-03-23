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

  int currentPage = 1; // الصفحة الحالية
  int totalPages = 1; // العدد الإجمالي للصفحات

  List<SubCategoryModel> subCategories = [];
  TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;
  String idc = '';
  void _onSearchTextChanged() {
    isSearchActive = searchController.text.isNotEmpty;
    emit(SearchStateChanged(isSearchActive));

    // ✅ استدعاء البحث مباشرة عند الكتابة
    fetchSubCategories(id: idc);
  }

  Future<void> fetchSubCategories({String? id, int page = 1}) async {
    emit(SubCategoryLoading());
    try {
      // ✅ تحميل الفئات
      final subcategoryResponse = await DioHelper.getData(
          url: Endpoints.subCategory(id),
          query: {'search': searchController.text, 'page': page});
      print("✅ الفئات المستلمة من API: ${subcategoryResponse.data}");

      if (subcategoryResponse.statusCode == 200) {
        // تحويل البيانات إلى كائن SubCategoryResponse
        final response = SubCategoryResponse.fromJson(subcategoryResponse.data);

        // التحقق من أن البيانات تحتوي على قائمة من الفئات
        if (response.data.isNotEmpty) {
          subCategories = response.data;
          idc = id!;
          currentPage = page;
          totalPages = response.totalPages!;
        } else {
          emit(SubCategoryFailure('❌ لا توجد فئات حالياً'));
          return;
        }
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

  void fetchNextPage() {
    if (currentPage < totalPages) {
      fetchSubCategories(id: idc, page: currentPage + 1);
    }
  }

  void fetchPreviousPage() {
    if (currentPage > 1) {
      fetchSubCategories(id: idc, page: currentPage - 1);
    }
  }
}
