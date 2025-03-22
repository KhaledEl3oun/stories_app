import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:stories_app/core/network/dio_helper.dart';
import 'package:stories_app/core/network/endpoints.dart';
import 'package:stories_app/feature/drawer/model/ret_app_model.dart';

part 'rat_application_state.dart';

class RatApplicationCubit extends Cubit<RatApplicationState> {
  RatApplicationCubit() : super(RatApplicationInitial());

  double rating = 0.0;
  TextEditingController commentController = TextEditingController();
  void ratApp() async {
    emit(RatApplicationLoading());
    try {
      final response = await DioHelper.postData(
        url: Endpoints.rating,
        headers: {'Authorization': 'Bearer ${GetStorage().read('token')}'},
        data: {'rating': rating, 'comment': commentController.text},
      );
      final responseData = response.data;
      debugPrint("🟢 Response Data: $responseData");
      if (responseData != null) {
        final retMOdel = ReviewModel.fromJson(responseData);
        emit(RatApplicationSucsses(retMOdel));
      } else {
        emit(RatApplicationFailure("حدث خطأ المحاولة مرة أخرى."));
      }
    } catch (error) {
      if (error is DioException) {
        emit(RatApplicationFailure(
            error.response?.data['message'] ?? "فشل في الارسال."));
      } else {
        emit(RatApplicationFailure("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا."));
      }
    }
  }
}
