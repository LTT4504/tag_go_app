import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../routes/app_routes.dart';
import '../../shared/service/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _auth = AuthService();
  final box = GetStorage();

  final loading = false.obs;
  final error = ''.obs;

  final username = ''.obs;
  final password = ''.obs;

  final showPassword = false.obs;
  final rememberMe = false.obs;

  /// --- Đăng nhập bằng Email ---
  Future<void> login() async {
    if (username.value.isEmpty || password.value.isEmpty) {
      _showError('Vui lòng nhập đầy đủ thông tin');
      return;
    }

    loading.value = true;
    error.value = '';

    try {
      final cred = await _auth.signInWithEmailPassword(
        username.value.trim(),
        password.value.trim(),
      );

      if (cred != null) {
        _saveUser(cred.user, method: 'email');
        Get.offAllNamed(AppRoutes.home);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          _showError('Tài khoản không tồn tại');
          break;
        case 'wrong-password':
          _showError('Mật khẩu không đúng');
          break;
        default:
          _showError(e.message ?? 'Đăng nhập thất bại');
      }
    } on PlatformException catch (e) {
      _showError('Lỗi hệ thống: ${e.message}');
    } catch (e) {
      _showError('Lỗi đăng nhập: $e');
    } finally {
      loading.value = false;
    }
  }

  /// --- Đăng nhập bằng Google ---
  Future<void> loginWithGoogle() async {
    loading.value = true;
    try {
      final cred = await _auth.signInWithGoogle();
      if (cred?.user != null) {
        _saveUser(cred!.user, method: 'google');
        Get.offAllNamed(AppRoutes.home);
      } else {
        _showError('Không thể đăng nhập bằng Google');
      }
    } catch (e) {
      _showError('Lỗi đăng nhập Google: $e');
    } finally {
      loading.value = false;
    }
  }

  /// --- Đăng nhập ẩn danh ---
  Future<void> continueAsGuest() async {
    loading.value = true;
    try {
      final cred = await _auth.signInAnonymously();
      if (cred != null) {
        _saveUser(cred.user, method: 'guest');
        Get.offAllNamed(AppRoutes.home);
      } else {
        _showError('Không thể đăng nhập ẩn danh');
      }
    } catch (e) {
      _showError('Lỗi đăng nhập khách: $e');
    } finally {
      loading.value = false;
    }
  }

  /// --- Lưu thông tin user ---
  void _saveUser(User? user, {required String method}) {
    if (user == null) return;
    box.write("token", user.uid);
    box.write("email", user.email);
    box.write("loginMethod", method);
    box.write("rememberMe", rememberMe.value);
  }

  void togglePassword() => showPassword.value = !showPassword.value;

  void _showError(String message) {
    error.value = message;
    Get.snackbar(
      "Đăng nhập thất bại",
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }
}
