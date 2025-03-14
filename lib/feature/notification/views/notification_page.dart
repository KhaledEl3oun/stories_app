import 'package:flutter/material.dart';
import 'notification.dart';
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      context.read<ThemeCubit>().toggleTheme();

                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/images/moon.png'),
                    ),
                  ),
                  Row(
                    children: [
                      AppText(
                        text: 'الاشعارات',
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.primaryColor),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_forward)),
                    ],
                  ),
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                              ? Colors.grey[900]
                              : Colors.white,
                        ),
                        height: 70,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 8),
                          child: AppText(
                              text: 'قصة جديدة مميزة متاحة الآن لتساعد طفلك في تعلم كلمات جديدة بطريقة ممتعة!'),
                        ),
                      ),
                  );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
