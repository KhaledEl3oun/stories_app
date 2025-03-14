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
  }) async {
    return await dio.get(url, queryParameters: query);
  }

  // 🔵 طلب **POST** لإرسال البيانات
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dio.post(url, data: data);
  }

  // 🟠 طلب **PUT** لتحديث البيانات
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dio.put(url, data: data);
  }

  // 🔴 طلب **DELETE** لحذف البيانات
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    return await dio.delete(url, data: data);
  }
}
