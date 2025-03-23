// import 'dart:typed_data';
// import 'package:dio/dio.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';

// Future<void> downloadAndSaveImage(String imageUrl) async {
//   var status = await Permission.storage.request();

//   if (status.isGranted) {
//     try {
//       var response = await Dio().get(
//         imageUrl,
//         options: Options(responseType: ResponseType.bytes),
//       );

//       final Uint8List imageBytes = Uint8List.fromList(response.data);
//       final result = await ImageGallerySaver.saveImage(imageBytes);
      
//       if (result['isSuccess']) {
//         print("✅ تم حفظ الصورة بنجاح!");
//       } else {
//         print("❌ فشل حفظ الصورة!");
//       }
//     } catch (e) {
//       print("❌ خطأ أثناء تحميل الصورة: $e");
//     }
//   } else {
//     print("🚫 المستخدم رفض إذن التخزين!");
//   }
// }
