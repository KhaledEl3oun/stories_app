import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:stories_app/core/network/dio_helper.dart';
import 'package:stories_app/core/network/endpoints.dart';
import 'package:stories_app/feature/drawer/model/user_model.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserInitial());
  TextEditingController currentPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  void userUpdata() async {
    emit(UpdateUserLoading());
    try {
     
      final response = await DioHelper.putData(
        url: Endpoints.changeMyPasswordAccount,
        headers: {'Authorization': 'Bearer ${GetStorage().read('token')}'},
        data: {
          'currentPassword': currentPassword.text,
          'password': password.text,
          'passwordConfirm': passwordConfirm.text
        },
      );
      final responseData = response.data;
      debugPrint("🟢 Response Data: $responseData");
      if (responseData != null) {
        final retMOdel = UserUpdateModel.fromJson(responseData);
        GetStorage().write('token', responseData['token']);
        debugPrint("🟢 Token: ${GetStorage().read('token')}");
        emit(UpdateUserSucsses(retMOdel));
      } else {
        emit(UpdateUserFailure("حدث خطأ المحاولة مرة أخرى."));
      }
    } catch (error) {
      debugPrint("🔴 Error: $error");
      if (error is DioException) {
        emit(UpdateUserFailure(
            error.response?.data['message'] ?? "فشل في الارسال."));
      } else {
        emit(UpdateUserFailure("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا."));
      }
    }
  }
}
