import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../shared/service/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService _auth = AuthService();

  /// Dark Mode state
  var isDarkMode = false.obs;

  /// Lấy tên hiển thị
  String get displayName => _auth.currentUser?.displayName ?? 'Guest';

  /// Lấy email
  String? get email => _auth.currentUser?.email;

  /// Logout
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  /// Toggle theme giữa Light / Dark
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
