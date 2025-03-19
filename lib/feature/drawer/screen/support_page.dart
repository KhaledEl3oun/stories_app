import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';
import 'package:stories_app/feature/home/views/widget/custom_row_header.dart';

class SupportPage extends StatelessWidget {
  SupportPage({super.key});

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
                title: 'الدعم الفني',
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
                      'إذا كنت بحاجة إلى أي مساعدة أو لديك استفسارات، لا تتردد في التواصل معنا عبر الوسائل التالية و سيتم الرد على جميع استفساراتك بأسرع وقت ممكن'),
              const SizedBox(height: 20,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                AppText(text: 'رقم الهاتف'),

                AppText(text: 'البريد الالكتروتى'),
              ],),
              const SizedBox(height: 10,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(text: '0101234455568',textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15)),

                  AppText(text: 'support@example.com',textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15)),
                ],),

            ],
          ),
        ),
      ),
    );
  }
}
