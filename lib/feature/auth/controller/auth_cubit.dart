import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/shared.dart';

import '../../../core/network/dio_helper.dart';
import '../../../core/network/endpoints.dart';
import '../model/message_model.dart';
import '../model/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  late UserModel userModel;
  final box = GetStorage();

  static AuthCubit get(context) => BlocProvider.of(context);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    try {
      // 🔹 تسجيل الدخول باستخدام Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(AuthFailure("تم إلغاء تسجيل الدخول من قبل المستخدم."));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 🔹 إنشاء بيانات الاعتماد باستخدام Google Access Token
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 🔹 تسجيل الدخول في Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // 🔹 الحصول على بيانات المستخدم
      final User? user = userCredential.user;
      debugPrint("🟢 User: $user");
      if (user == null) {
        print("❌ User is null");
        emit(AuthFailure("لم يتم استرجاع بيانات المستخدم."));
        return;
      }

      // 🔹 الحصول على Token
      final String? token = await user.getIdToken();
      debugPrint("🟢 Token: $token");
      if (token == null) {
        emit(AuthFailure("لم يتم استرجاع التوكن."));
        return;
      }

      // 🔹 حفظ البيانات محليًا
      box.write('token', token);
      box.write('user', {
        'name': user.displayName,
        'email': user.email,
        'photo': user.photoURL,
        'uid': user.uid,
      });

      // 🔹 إرسال الحالة الناجحة مع بيانات المستخدم
      emit(AuthGoogleSuccess(token, user.displayName ?? "مستخدم غير معروف"));
    } catch (e) {
      debugPrint("🔴 Error: $e");
      print("❌ Error: $e");
      emit(AuthFailure("حدث خطأ أثناء تسجيل الدخول: $e"));
    }
  }

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

    // طباعة الرد من الـ API لمعرفة إن كان هناك مشكلة في البيانات
    print("📌 API Response: ${response.data}");

    if (response.statusCode == 201 && response.data.containsKey("data")) {
      var responseData = response.data['data'];

      // التأكد من أن البيانات ليست `null` وأنها من نوع `Map<String, dynamic>`
      if (responseData != null && responseData is Map<String, dynamic>) {
        final userModel = UserModel.fromJson(responseData);

        // تحويل `UserModel` إلى JSON قبل التخزين
        box.write('userModel', userModel.toJson());

        // استرجاع `UserModel` بعد قراءته من التخزين
        currentUser = UserModel.fromJson(box.read('userModel'));

        emit(AuthRegistered(userModel));
      } else {
        emit(AuthFailure("❌ البيانات غير صحيحة أو فارغة!"));
      }
    } else {
      emit(AuthFailure("❌ فشل إنشاء الحساب، استجابة غير متوقعة!"));
    }
  } catch (error) {
    if (error is DioException) {
      print("❌ Dio Error: ${error.response?.data}");

      emit(AuthFailure(
          error.response?.data['message'] ?? "❌ حدث خطأ أثناء إنشاء الحساب"));
    } else {
      print("❌ Unexpected Error: $error");
      emit(AuthFailure("❌ حدث خطأ غير متوقع"));
    }
  }
}

// الدخول ك زائر
Future<void> signInAnonymously(BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    print("✅ تسجيل الدخول كزائر ناجح: ${userCredential.user?.uid}");

    if (context.mounted) {  // حل مشكلة use_build_context_synchronously
      Navigator.pushReplacementNamed(context,AppRoutes.homeScreen);
    }
  } catch (e) {
    print("❌ خطأ في تسجيل الدخول كزائر: $e");
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
       print("❌ فشل الاتصال بالسيرفر: $error");
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
        headers: {},
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
  void logout(BuildContext context) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    box.remove('token');
    box.remove('userName');
    Navigator.pushReplacementNamed(context, '/loginScreen');
  }

  void updateUserData({String? userName, String? email, String? phone}) async {
    emit(AuthLoading());
    try {
      String? token = box.read('token'); // 🟢 جلب التوكين
      print(
          "🔵 Loaded Token: ${token ?? 'No Token Found'}"); // ✅ طباعة التوكين قبل الإرسال

      final response = await DioHelper.putData(
        url: "https://app.balady-sa.pro/api/v1/user/updateMyData",
        data: {
          if (userName != null) 'userName': userName,
          if (email != null) 'email': email,
          if (phone != null) 'phone': phone,
        },
        token: token,
        headers: {},
      );

      final userModel = UserModel.fromJson(response.data);
      box.write('userName', userModel.userName);
      box.write('email', userModel.email);
      box.write('phone', userModel.phone);
      emit(AuthUpdated(userModel));
    } catch (error) {
      print("❌ Error: $error");
      emit(AuthFailure("❌ حدث خطأ أثناء تحديث البيانات!"));
    }
  }

void deleteAccount() async {
  emit(AuthLoading());
  try {
    String? token = box.read('token');
    if (token == null) {
      emit(AuthFailure("لم يتم العثور على التوكين، الرجاء تسجيل الدخول."));
      return;
    }

    final response = await DioHelper.deleteData(
      url: '/api/v1/user/deleteMyAcc',
      data: {}, headers: {
         "Authorization": "Bearer $token",
      }, // ممكن يكون الـ API مش محتاج بيانات، لو محتاج أضفها هنا
    );

    final responseData = response.data;
    debugPrint("🟢 Response Data: $responseData");

    if (response.statusCode == 200) {
      box.erase(); // ✅ مسح بيانات المستخدم من التخزين
      print('okkkkkkkk');
      emit(AuthLoggedOut());
    } else {

      emit(AuthFailure("حدث خطأ أثناء حذف الحساب، حاول مرة أخرى."));
    }
  } catch (error) {
    if (error is DioException) {
      print('error:${error.response?.data}');
      emit(AuthFailure(
          error.response?.data['message'] ?? "فشل في حذف الحساب."));
    } else {
      emit(AuthFailure("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا."));
    }
  }
}

}
