import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:stories_app/core/network/dio_helper.dart';
import 'package:stories_app/core/theme/themes.dart';
import 'package:stories_app/feature/home/model/sub_story_model.dart';

import '../../../core/network/endpoints.dart';

part 'sub_story_state.dart';

class SubStoryCubit extends Cubit<SubStoryState> {
  SubStoryCubit() : super(SubStoryInitial()) {
    searchController.addListener(_onSearchTextChanged);
  }

  int currentPage = 1; // الصفحة الحالية
  int totalPages = 1; // العدد الإجمالي للصفحات

  List<SubStoryModel> subStory = [];
  TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;
  String idc = '';
  void _onSearchTextChanged() {
    isSearchActive = searchController.text.isNotEmpty;
    emit(SearchStateChanged(isSearchActive));

    // ✅ استدعاء البحث مباشرة عند الكتابة
    fetchSubStory(id: idc);
  }

  Future<void> fetchSubStory({String? id, int page = 1}) async {
    emit(SubStoryLoading());
    try {
      // ✅ تحميل الفئات
      final subStoryResponse = await DioHelper.getData(
        url: Endpoints.substory(id),
        headers: {'Authorization': 'Bearer ${GetStorage().read('token')}'},
        query: {'search': searchController.text, 'page': page},
      );
      print("✅ الفئات المستلمة من API: ${subStoryResponse.data}");

      if (subStoryResponse.statusCode == 200 &&
          subStoryResponse.data['data'] is List) {
        // تحويل الاستجابة إلى موديل SubStoryResponse
        SubStoryResponse subStoryResponseData =
            SubStoryResponse.fromJson(subStoryResponse.data);

        // إذا كانت الاستجابة تحتوي على بيانات صحيحة، نقوم بتخزين البيانات في المتغير
        subStory = subStoryResponseData.data;
        idc = id!;
        currentPage = page;
        totalPages = subStoryResponseData.totalPages!;
        // إرسال البيانات إلى الحالة الناجحة
        emit(SubStorySuccess(subStory));
      } else {
        emit(SubStoryFailure('❌ خطأ أثناء تحميل الفئات'));
        return;
      }
    } catch (e) {
      print("❌ فشل الاتصال بالسيرفر: $e");
      emit(SubStoryFailure("فشل الاتصال بالسيرفر"));
    }
  }

  void fetchNextPage() {
    if (currentPage < totalPages) {
      fetchSubStory(id: idc, page: currentPage + 1);
    }
  }

  void fetchPreviousPage() {
    if (currentPage > 1) {
      fetchSubStory(id: idc, page: currentPage - 1);
    }
  }
}
