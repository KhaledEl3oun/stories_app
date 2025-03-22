import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://194.164.77.238:8002',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  // 🟢 طلب **GET** لجلب البيانات
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    String? token,
  }) async {
    return await dio.get(url,
        queryParameters: query, options: Options(headers: headers));
  }

  // 🔵 طلب **POST** لإرسال البيانات
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.post(url, data: data, options: Options(headers: headers));
  }

  // 🟠 طلب **PUT** لتحديث البيانات
<<<<<<< HEAD
 static Future<Response> putData({
  required String url,
  required Map<String, dynamic> data,
  String? token,
}) async {
  return await dio.put(
    url,
    data: data,
    options: Options(
      headers: {
        if (token != null) "Authorization": "Bearer $token", // ✅ لا ترسل الهيدر لو التوكن غير موجود
        "Content-Type": "application/json",
      },
    ),
  );
}

=======
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.put(url, data: data, options: Options(headers: headers));
  }
>>>>>>> 9ae9e37eeb2f6a027fb6735e992c6cb6be7ed202

  // 🟠 طلب **patch** لتحديث البيانات
  static Future<Response> patchData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.patch(url, data: data, options: Options(headers: headers));
  }

  // 🔴 طلب **DELETE** لحذف البيانات
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    return await dio.delete(url, data: data);
  }
}
