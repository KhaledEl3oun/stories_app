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

 static Future<Response> putData({
  required String url,
  required Map<String, dynamic> data,
  String? token,
  required Map<String, String> headers,
}) async {
  final finalHeaders = {
    "Content-Type": "application/json",
    if (token != null && token.isNotEmpty) "Authorization": "Bearer $token",
  };

  // ✅ طباعة الهيدرز للتأكد إن التوكين بيتبعت
  print("🔵 Headers being sent: $finalHeaders");

  return await dio.put(
    url,
    data: data,
    options: Options(headers: finalHeaders),
  );
}





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
