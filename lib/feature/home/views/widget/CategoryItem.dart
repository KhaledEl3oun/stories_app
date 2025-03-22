import 'package:flutter/material.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/feature/home/model/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ الحصول على حجم الشاشة بشكل ديناميكي
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: screenWidth * 0.02), // ✅ جعل الهوامش ديناميكية
        padding: EdgeInsets.all(screenWidth * 0.02), // ✅ استخدام نسبة من العرض بدلاً من قيمة ثابتة
        width: screenWidth * 0.35, // ✅ تناسب مع عرض الشاشة
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor == const Color(0xff191201)
              ? const Color(0xff2b1e08)
              : Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.03), // ✅ تحديد الحواف بشكل متناسق مع الشاشة
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // ✅ السماح للـ Column بأخذ الحد الأدنى من المساحة
          children: [
            Flexible( // ✅ يمنع Overflow عن طريق السماح للصورة بالتكيف مع الحاوية
              child: Container(
                width: screenWidth * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  image: DecorationImage(
                    image: NetworkImage(category.image),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      debugPrint("❌ فشل تحميل صورة الفئة: ${category.image}");
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01), // ✅ جعل المسافة ديناميكية
            Center(
              child: Text(
                category.name,
                textAlign: TextAlign.center, // ✅ ضمان تنسيق النص بشكل صحيح
                style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: screenWidth * 0.04, // ✅ تناسب حجم الخط مع الشاشة
                  color: Theme.of(context).scaffoldBackgroundColor == const Color(0xff191201)
                      ? AppColors.white
                      : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
