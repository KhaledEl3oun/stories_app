import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/button/app_button.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/core/widget/text_failed/custom_text_failed.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';
import 'package:stories_app/feature/home/widget/custom_row_header.dart';

class RateAppPage extends StatelessWidget {
  RateAppPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: AppPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 50),
              AppBarCustom(
                title: 'تقييم التطبيق',
                scaffoldKey: _scaffoldKey,
              ),
              const SizedBox(height: 20),
              Center(
                  child: Image.asset(
                      width: 190,
                      height: 190,
                      'assets/images/support_page.png')),
              const SizedBox(
                height: 10,
              ),
              AppText(
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                  text:
                  'ساعدنا في تحسين التطبيق من خلال تقييمك.لديك ملاحظات أو اقتراحات؟'),
              const SizedBox(height: 20,),
              Center(
                child: RatingBar.builder(
                  unratedColor: Theme.of(context).scaffoldBackgroundColor == Colors.black
                    ? Colors.grey[900]
                    : Colors.grey,
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {

                  },
                ),
              ),
              const SizedBox(height: 20,),
              const CustomTextField(),
              const SizedBox(height: 50,),
              Center(
                child: AppButton(
                  minimumSize: MaterialStateProperty.all(const Size(375, 50)),
                  onPressed: () {

                  },
                  text: 'ارسال',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
