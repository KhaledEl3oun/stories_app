import 'package:flutter/material.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';
import 'package:stories_app/feature/home/views/widget/custom_row_header.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}
class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      body: 
      
      Container(
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Theme.of(context).scaffoldBackgroundColor == const Color(0xff191201)
                  ? 'assets/images/darkBg.png' // ✅ خلفية الدارك
                  : 'assets/images/lightBg.png', // ✅ خلفية اللايت
            ),
            fit: BoxFit.cover, // ✅ جعل الصورة تغطي الشاشة بالكامل
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 50),
                AppBarCustom(
                  title: 'سياسة الخصوصية',
                  scaffoldKey: _scaffoldKey,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 50),
                AppText(
                  text:
                      'مرحبًا بك في تطبيق "احترف الإنجليزية". نحن ملتزمون بحماية خصوصيتك وضمان استخدام بياناتك بشكل آمن. توضح هذه السياسة كيفية جمع بياناتك واستخدامها وحمايتها عند استخدام التطبيق.',
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey, fontSize: 18),
                ),
                const SizedBox(height: 20),
                const CustomExpansionTile(
                  title: 'المعلومات التي نجمعها',
                  content: '''
        معلومات تسجيل الدخول:
        عند تسجيل الدخول باستخدام حساب Google أو البريد الإلكتروني، نجمع اسمك، عنوان بريدك الإلكتروني، ومعرّف المستخدم.
        معلومات الاستخدام:
        بيانات حول كيفية استخدامك للتطبيق، مثل الصفحات التي تزورها، الوقت الذي تقضيه في التطبيق، وتفاعلك مع المحتوى.
        المعلومات التقنية:
        نوع جهازك، نظام التشغيل، وإصدار التطبيق.
        بيانات الإعلانات:
        معلومات تتعلق بالإعلانات التي يتم عرضها أو التفاعل معها (مقدمة من AdMob).
        ''',
                ),
                const SizedBox(height: 20),
                const CustomExpansionTile(
                  title: 'كيفية استخدام المعلومات',
                  content:
                      'تحسين وتطوير خدمات التطبيق. تخصيص تجربة المستخدم بناءً على اهتماماته. عرض الإعلانات المناسبة عبر منصة AdMob. تقديم الدعم الفني عند الحاجة. الامتثال للمتطلبات القانونية والتنظيمية.',
                ),
                const SizedBox(height: 20),
                const CustomExpansionTile(
                  title: 'الإعلانات',
                  content:
                      'يعتمد تطبيق "احترف الإنجليزية" على منصة AdMob لعرض الإعلانات. قد تقوم AdMob بجمع بيانات مجهولة مثل موقعك التقريبي أو نوع جهازك لتحسين تجربة الإعلانات. لمزيد من المعلومات حول كيفية تعامل AdMob مع بياناتك، يرجى مراجعة سياسة الخصوصية الخاصة بـ AdMob: https://policies.google.com/privacy.',
                ),
                const SizedBox(height: 20),
                const CustomExpansionTile(
                  title: 'حقوقك',
                  content:
                      'الوصول إلى البيانات التي نجمعها عنك. طلب تصحيح أو حذف بياناتك. سحب موافقتك على استخدام بياناتك. لأي استفسارات حول بياناتك الشخصية، يرجى التواصل معنا عبر البريد الإلكتروني: admin@ehtrf.com',
                ),
                const SizedBox(height: 20),
                const CustomExpansionTile(
                    title: 'التواصل معنا',
                    content:
                        'إذا كان لديك أي أسئلة حول سياسة الخصوصية، يرجى التواصل معنا عبر البريد الإلكتروني'),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final String content;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).scaffoldBackgroundColor == const Color(0xff191201);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // إخفاء الخط الفاصل تحت العنوان
        ),
        child: ExpansionTile(
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          trailing: Transform.scale(
            scale: 1.5,
            child: AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.orangeAccent,
              ),
            ),
          ),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
          collapsedShape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent),
          ),

          // ✅ تطبيق الـ TextStyle المخصص هنا مباشرة داخل ExpansionTile
          title: Text(
            widget.title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Cairo',
              color: isDarkMode ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 0, 0, 0), // ✅ تحديد اللون حسب الوضع
              fontSize: 20,
              fontWeight: FontWeight.bold, // ✅ إضافة وزن للخط ليكون أوضح
            ),
          ),

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AppText(
                text: widget.content,
                textAlign: TextAlign.right,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
