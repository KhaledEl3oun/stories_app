import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/endpoints.dart';
import '../model/user_model.dart';
import '../model/message_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  late UserModel userModel;
  final box = GetStorage();

  static AuthCubit get(context) => BlocProvider.of(context);

  // 🟢 تسجيل الدخول
  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await DioHelper.postData(
        url: Endpoints.login,
        data: {'email': email, 'password': password},
      );
      final responseData = response.data;
      debugPrint("🟢 Response Data: $responseData");
      if (responseData != null && responseData['token'] != null) {
        final userModel = UserModel.fromJson(responseData);

        box.write('token', responseData['token']);
        box.write('userName', responseData['data']['userName']);
        emit(AuthLoggedIn(userModel));
      } else {
        emit(
            AuthFailure("حدث خطأ أثناء تسجيل الدخول، يرجى المحاولة مرة أخرى."));
      }
    } catch (error) {
      if (error is DioException) {
        emit(AuthFailure(
            error.response?.data['message'] ?? "فشل في تسجيل الدخول."));
      } else {
        emit(AuthFailure("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا."));
      }
    }
  }

  // 🔵 تسجيل حساب جديد
  void register(String userName, String email, String phone, String password,
      String passwordConfirm) async {
    emit(AuthLoading());
    try {
      final response = await DioHelper.postData(
        url: Endpoints.register,
        data: {
          'userName': userName,
          'email': email,
          'phone': phone,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );
      if (response.statusCode == 201 && response.data.containsKey("data")) {
        final userModel = UserModel.fromJson(response.data);
        box.write('userName', userName);
        emit(AuthRegistered(userModel));
      } else {
        emit(AuthFailure("فشل إنشاء الحساب، استجابة غير متوقعة!"));
      }
    } catch (error) {
      if (error is DioException) {
        emit(AuthFailure(
            error.response?.data['message'] ?? "حدث خطأ أثناء إنشاء الحساب"));
      } else {
        emit(AuthFailure("حدث خطأ غير متوقع"));
      }
    }
  }

  // 🟠 **طلب إعادة تعيين كلمة المرور (Forgot Password)**
  void forgotPassword(String email) async {
    emit(AuthLoading());
    try {
      final response = await DioHelper.postData(
        url: Endpoints.forgetPassword, // الـ endpoint الخاص بيها
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        final messageModel = MessageModel.fromJson(response.data);
        emit(AuthSuccess(messageModel.message));
      } else {
        emit(AuthFailure("فشل إرسال طلب إعادة تعيين كلمة المرور"));
      }
    } catch (error) {
      emit(AuthFailure("حدث خطأ أثناء إرسال طلب إعادة تعيين كلمة المرور"));
    }
  }

  // 🟣 **التحقق من كود إعادة التعيين (Verify Reset Code)**
  void verifyResetCode(String resetCode) async {
    emit(AuthLoading());
    try {
      final response = await DioHelper.postData(
        url: Endpoints.verifyResetCode,
        data: {'resetCode': resetCode},
      );

      if (response.statusCode == 200) {
        final messageModel = MessageModel.fromJson(response.data);
        emit(AuthSuccess(messageModel.message));
      } else {
        print("❌ خطأ في البيانات: ${response.data}");
        emit(AuthFailure("كود التحقق غير صحيح"));
      }
    } catch (error) {
      print("❌ فشل الاتصال بالسيرفر: $error");
      emit(AuthFailure("حدث خطأ أثناء التحقق من الكود"));
    }
  }

  // 🟢 **إعادة تعيين كلمة المرور بعد التحقق**
  void resetPassword(String newPassword, String confirmNewPassword) async {
    emit(AuthLoading());
    try {
      final response = await DioHelper.putData(
        url: Endpoints.resetPassword,
        data: {
          'newPassword': newPassword,
          'confirmNewPassword': confirmNewPassword,
        },
      );

      if (response.statusCode == 200) {
        final messageModel = MessageModel.fromJson(response.data);
        emit(AuthSuccess(messageModel.message)); // عرض رسالة نجاح
      } else {
        emit(AuthFailure("فشل إعادة تعيين كلمة المرور"));
      }
    } catch (error) {
      emit(AuthFailure("حدث خطأ أثناء إعادة تعيين كلمة المرور"));
    }
  }

  // 🔴 **تسجيل الخروج**
  void logout(BuildContext context) {
    box.remove('token');
    box.remove('userName');
    Navigator.pushReplacementNamed(context, '/loginScreen');
  }
}
