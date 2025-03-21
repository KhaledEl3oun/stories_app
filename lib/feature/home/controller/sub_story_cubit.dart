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
  List<SubStoryModel> subStory = [];
  TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;
  String idc = '';
  void _onSearchTextChanged() {
    isSearchActive = searchController.text.isNotEmpty;
    emit(SearchStateChanged(isSearchActive));

    // ✅ استدعاء البحث مباشرة عند الكتابة
    fetchSubStory(idc);
  }

  Future<void> fetchSubStory(String id) async {
    emit(SubStoryLoading());
    try {
      // ✅ تحميل الفئات
      final subStoryResponse = await DioHelper.getData(
          url: Endpoints.substory(id),
          headers: {'Authorization': 'Bearer ${GetStorage().read('token')}'},
          query: {'search': searchController.text});
      print("✅ الفئات المستلمة من API: ${subStoryResponse.data}");

      if (subStoryResponse.statusCode == 200 &&
          subStoryResponse.data['data'] is List) {
        subStory = (subStoryResponse.data['data'] as List)
            .map((subcategory) => SubStoryModel.fromJson(subcategory))
            .toList();
        idc = id;
      } else {
        emit(SubStoryFailure('❌ خطأ أثناء تحميل الفئات'));
        return;
      }
      emit(SubStorySuccess(subStory));
    } catch (e) {
      print("❌ فشل الاتصال بالسيرفر: $e");
      emit(SubStoryFailure("فشل الاتصال بالسيرفر"));
    }
  }
}
