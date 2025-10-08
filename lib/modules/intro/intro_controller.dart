import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class IntroController extends GetxController {
  final page = 0.obs;
  final box = GetStorage();
  final pageController = PageController();

  void next() {
    if (page.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      done();
    }
  }

  /// Bỏ qua hoặc hoàn tất
  void skip() => done();

  void done() {
    box.write('is_first_time', false); 
    final isLoggedIn = box.read('is_logged_in') ?? false;

    if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.home); 
    } else {
      Get.offAllNamed(AppRoutes.splash); 
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
