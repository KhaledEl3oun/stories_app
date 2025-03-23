import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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

class _MyAccountState extends State<MyAccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
  final box = GetStorage();
 String? userName = box.read('userName');  
 String? phone = box.read('phone');  
 String? email = box.read('email');  
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      body: Stack(
        children: [
            Positioned.fill(
        child: Image.asset(
          Theme.of(context).scaffoldBackgroundColor == const Color(0xff191201)
              ? 'assets/images/darkBg.png' // خلفية الدارك
              : 'assets/images/lightBg.png', // خلفية اللايت
          fit: BoxFit.cover, // ✅ جعل الصورة تغطي الشاشة بالكامل
        ),
      ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                child: AppPadding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 40),
                      AppBarCustom(title: 'حسابي', scaffoldKey: _scaffoldKey),
                      const SizedBox(height: 40),
                      Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (imagePath != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenImage(imagePath!),
                                    ),
                                  );
                                }
                              },
                              onLongPress: () {
                                if (imagePath != null) {
                                  _showDeleteDialog();
                                }
                              },
                              child: CircleAvatar(
                                radius: 85,
                                backgroundColor: AppColors.primaryColor,
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: imagePath != null
                                      ? FileImage(File(imagePath!)) as ImageProvider
                                      : AssetImage('assets/images/person.png'),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: InkWell(
                                onTap: _showImagePickerDialog,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Icon(Icons.camera_alt, size: 30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ProfileItem(title: 'الاسم', value: userName?? '', onTap: () => context.pushNamed(AppRoutes.updateName)),
                      ProfileItem(title: 'الهاتف', value: phone?? '', onTap: () => context.pushNamed(AppRoutes.updatePhone)),
                      ProfileItem(title: 'البريد الالكترونى', value: email?? '', onTap: () => context.pushNamed(AppRoutes.updateEmail)),
                      ProfileItem(title: 'كلمة المرور', value: '********', onTap: () => context.pushNamed(AppRoutes.updatePassword)),
                    ],
                  ),
                ),
                        ),
              ),
            ],
          ),
      ]),
    );
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor == Color(0xff191201)
              ? Color(0xff2b1e08)
              : Colors.white,
          title: AppText(text: 'اختر الصورة', textStyle: TextStyle(color: AppColors.primaryColor, fontFamily: 'cairo')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: AppText(text: 'الكاميرا', textStyle: TextStyle(color: AppColors.primaryColor, fontFamily: 'cairo')),
                onTap: () {
                  _uploadFromCamera();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: AppText(text: 'المعرض', textStyle: TextStyle(color: AppColors.primaryColor, fontFamily: 'cairo')),
                onTap: () {
                  _uploadFromGallery();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor == Color(0xff191201)
              ? Color(0xff2b1e08)
              : Colors.white,
          title: AppText(text: 'اختر الصورة', textStyle: TextStyle(color: AppColors.primaryColor, fontFamily: 'cairo')),
          content:AppText(text: 'هل تريد حذف الصورة؟', textStyle: TextStyle(color: AppColors.primaryColor, fontFamily: 'cairo')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: AppText(text: 'إلغاء', textStyle: TextStyle(color: AppColors.primaryColor, fontFamily: 'cairo')),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  imagePath = null;
                });
                Navigator.pop(context);
              },
              child: AppText(text: 'حذف', textStyle: TextStyle(color: AppColors.primaryColor, fontFamily: 'cairo')),
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadFromCamera() async {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
      });
    }
  }

  Future<void> _uploadFromGallery() async {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
      });
    }
  }
}

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  const FullScreenImage(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: InteractiveViewer(
            child: Image.file(File(imagePath), fit: BoxFit.contain),
          ),
        ),
      ),
    );
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
