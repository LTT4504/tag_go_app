import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:taggo/app_binding.dart';
import 'package:taggo/routes/app_pages.dart';
import 'package:taggo/theme/app_theme.dart';

class TagGoApp extends StatelessWidget {
  final String initialRoute;
  const TagGoApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TagGo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      initialRoute: initialRoute,
      defaultTransition: Transition.cupertino,
      getPages: AppPages.pages,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      builder: EasyLoading.init(), 
    );
  }
}

