import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stories_app/core/extension/navigator.dart';
import 'package:stories_app/core/route/app_routes.dart';
import 'package:stories_app/core/theme/app_colors.dart';
import 'package:stories_app/core/widget/app_padding/app_padding.dart';
import 'package:stories_app/core/widget/text/app_text.dart';
import 'package:stories_app/feature/drawer/drawer_page.dart';
import 'package:stories_app/feature/home/views/widget/custom_row_header.dart';

class MyAccount extends StatefulWidget {
  MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}
String? path;
class _MyAccountState extends State<MyAccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      body:
       SingleChildScrollView(
        child: AppPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 40),
              AppBarCustom(title: 'حسابي',scaffoldKey: _scaffoldKey,),
              const SizedBox(height: 40),
               Center(child:  Stack(
                 children: [
                    CircleAvatar(
                      radius: 85,
                      backgroundColor: AppColors.primaryColor,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: path != null
                            ? FileImage(File(path!)) as ImageProvider
                            : AssetImage('assets/images/person.png'),
                      ),
                    ),
                  Container(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.camera_alt,size: 30,),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                   ) ),
                  ],
               ),),
              const SizedBox(height: 20),
              ProfileItem(
                title: 'الاسم',
                value: 'عمر محمد',
                onTap: () {
                  context.pushNamed(AppRoutes.updateName);
                },
              ),
              ProfileItem(
                title: 'الهاتف',
                value: '010123456789',
                onTap: () {
                  context.pushNamed(AppRoutes.updatePhone);

                },
              ),
              ProfileItem(
                title: 'البريد الالكترونى',
                value: 'omarmohamed@example.com',
                onTap: () {
                  context.pushNamed(AppRoutes.updateEmail);
                },
              ),
              ProfileItem(
                title: 'كلمة المرور',
                value: '********',
                onTap: () {
                  context.pushNamed(AppRoutes.updatePassword);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  uploadFromCamera() async {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        path = pickedImage.path;
      });
    }
  }

  uploadFromGallery() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        path = pickedImage.path;
      });
    }
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const ProfileItem({
    required this.title,
    required this.value,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Image.asset('assets/images/edit.png'),
            ),
            AppText(text: title),
          ],
        ),
        AppText(
          text: value,
          textStyle: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

}
