import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/feature/home/model/story_model.dart';

class StoryItem extends StatelessWidget {
  final StoryModel story;
  final VoidCallback onTap;

  const StoryItem({
    super.key,
    required this.story,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.02), // بدل 8 ثابتة
        height: screenHeight * 0.35, // بدل 290.h
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor == const Color(0xff191201)
              ? const Color(0xff2b1e08)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.18, // بدل 140.h
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(story.imageCover),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    debugPrint("❌ فشل تحميل صورة القصة: ${story.imageCover}");
                  },
                ),
              ),
              child: story.imageCover.isNotEmpty
                  ? null
                  : Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: screenWidth * 0.1,
                        color: Colors.grey,
                      ),
                    ),
            ),
            Gap(screenHeight * 0.01), // بدل 5.h
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.title,
                  style: TextStyle(
                    fontFamily: "cairo",
                    color: Theme.of(context).scaffoldBackgroundColor == const Color(0xff191201)
                        ? AppColors.white
                        : Colors.black,
                    fontSize: screenWidth * 0.04, // بدل 14.dg
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(screenHeight * 0.01), // بدل 5.h
              ],
            ),
          ],
        ),
      ),
    );
  }
}
