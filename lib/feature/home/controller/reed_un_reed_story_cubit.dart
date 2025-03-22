import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:stories_app/core/network/endpoints.dart';
import 'package:stories_app/feature/home/model/reed_un_reed_story_model.dart';
import '../../../core/network/dio_helper.dart';

part 'reed_un_reed_story_state.dart';

class ReedUnReedStoryCubit extends Cubit<ReedUnReedStoryState> {
  ReedUnReedStoryCubit() : super(ReedUnReedStoryInitial());

  ReedUnReedStoryModel? readResponse;

  Future<void> markStoryAsRead(String storyId) async {
    emit(ReedUnReedStoryLoading());

    try {
      final response = await DioHelper.patchData(
        url: Endpoints.markStoryAsRead(storyId),
        headers: {
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        },
      );

      print("✅ استجابة API: ${response.data}");

      if (response.statusCode == 200) {
        readResponse = ReedUnReedStoryModel.fromJson(response.data);
        emit(ReedUnReedStorySuccess(readResponse!));
      } else {
        emit(ReedUnReedStoryFailure("❌ خطأ أثناء تحديث حالة القصة"));
      }
    } catch (e) {
      print("❌ فشل الاتصال بالسيرفر: $e");
      emit(ReedUnReedStoryFailure("فشل الاتصال بالسيرفر"));
    }
  }

  Future<void> markStoryUnRead(String storyId) async {
    emit(ReedUnReedStoryLoading());

    try {
      final response = await DioHelper.patchData(
        url: Endpoints.markStoryUnRead(storyId),
        headers: {
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        },
      );

      print("✅ استجابة API: ${response.data}");

      if (response.statusCode == 200) {
        readResponse = ReedUnReedStoryModel.fromJson(response.data);
        emit(ReedUnReedStorySuccess(readResponse!));
      } else {
        emit(ReedUnReedStoryFailure("❌ خطأ أثناء تحديث حالة القصة"));
      }
    } catch (e) {
      print("❌ فشل الاتصال بالسيرفر: $e");
      emit(ReedUnReedStoryFailure("فشل الاتصال بالسيرفر"));
    }
  }
}
