import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stories_app/feature/home/model/single_details_story.dart';

import '../../../core/network/dio_helper.dart';
import '../../../core/network/endpoints.dart';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:dio/dio.dart'; // إضافة dio

part 'single_details_story_state.dart';

class DetailsStoryCubit extends Cubit<DetailsStoryState> {
  DetailsStoryCubit() : super(SingleDetailsCategoryInitial());

  SingleStoryModel? subCategory;

  Future<void> fetchSingleStory(String id) async {
    emit(DetailsStoryLoading());
    try {
      // ✅ تحميل الفئة الفرعية من API
      final response =
          await DioHelper.getData(url: Endpoints.singleStory(id));
      print("✅ الفئة الفرعية المستلمة من API: ${response.data}");

      if (response.statusCode == 200 && response.data['data'] != null) {
        subCategory = SingleStoryModel.fromJson(response.data['data']);
        emit(DetailsStorySuccess(subCategory!));
      } else {
        emit(DetailsStoryFailure('❌ خطأ أثناء تحميل الفئة الفرعية'));
      }
    } catch (e) {
      print("❌ فشل الاتصال بالسيرفر: $e");
      emit(DetailsStoryFailure("فشل الاتصال بالسيرفر"));
    }
  }

  // Future<void> saveImageToGallery(String imageUrl) async {
  //   // طلب الأذونات
  //   PermissionStatus permission = await Permission.storage.request();

  //   // تحقق من ما إذا كان الإذن قد تم منحه
  //   if (permission.isGranted) {
  //     // تأكد من أن لديك الإذن لقراءة وتخزين الصور
  //     final PermissionState permissionState =
  //         await PhotoManager.requestPermissionExtend();

  //     if (permissionState != PermissionState.authorized) {
  //       print('Permission denied');
  //       return;
  //     }

  //     try {
  //       // استخدام dio لتحميل الصورة من URL
  //       Dio dio = Dio();
  //       Response response = await dio.get(
  //         imageUrl,
  //         options: Options(
  //             responseType: ResponseType.bytes), // تحميل الصورة كـ bytes
  //       );

  //       // تحقق من حالة الاستجابة
  //       if (response.statusCode == 200) {
  //         // قراءة البيانات (البايتات)
  //         Uint8List imageBytes = response.data;

  //         // تحديد اسم الصورة عند حفظها (يمكنك تخصيصه كما تريد)
  //         String title = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

  //         // احفظ الصورة في المعرض باستخدام PhotoManager
  //         final asset =
  //             await PhotoManager.editor.saveImage(imageBytes, title: title);

  //         if (asset != null) {
  //           print('Image saved successfully!');
  //         } else {
  //           print('Failed to save image');
  //         }
  //       } else {
  //         print('Failed to load image from URL');
  //       }
  //     } catch (e) {
  //       print('Error downloading image: $e');
  //     }
  //   } else {
  //     print('Storage permission denied');
  //   }
  // }
}
