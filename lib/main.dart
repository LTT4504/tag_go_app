import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  final box = GetStorage();

  final bool isFirstTime = box.read('is_first_time') ?? true;
  final bool isLoggedIn = box.read('is_logged_in') ?? false;

  String initialRoute;

  if (isFirstTime) {
    initialRoute = AppRoutes.intro;
  } else if (isLoggedIn) {
    initialRoute = AppRoutes.home;
  } else {
    initialRoute = AppRoutes.splash;
  }

  runApp(TagGoApp(initialRoute: initialRoute));
}

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
      getPages: AppPages.pages,
      builder: (context, child) {
        return SafeArea(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
