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

  /// Đăng nhập bằng Email & Password
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
        if (rememberMe.value) {
          box.write("token", cred.user?.uid);
          box.write("email", cred.user?.email);
          box.write("rememberMe", true);
        } else {
          box.remove("token");
          box.write("rememberMe", false);
        }
        Get.offAllNamed(AppRoutes.home);
      }
    } on FirebaseAuthException catch (e) {
      // Các lỗi FirebaseAuth chuẩn
      switch (e.code) {
        case 'user-not-found':
          _showError('Tài khoản không tồn tại');
          break;
        case 'wrong-password':
          _showError('Mật khẩu không đúng');
          break;
        case 'invalid-email':
          _showError('Email không hợp lệ');
          break;
        case 'user-disabled':
          _showError('Tài khoản đã bị vô hiệu hóa');
          break;
        case 'invalid-credential':
          _showError('Tài khoản hoặc mật khẩu không đúng');
          break;
        default:
          _showError(e.message ?? 'Đăng nhập thất bại');
      }
    } on PlatformException catch (e) {
      // Lỗi native của Firebase (Android/iOS)
      if (e.code == 'ERROR_INVALID_CREDENTIAL') {
        _showError('Tài khoản hoặc mật khẩu không đúng');
      } else {
        _showError('Lỗi hệ thống: ${e.message}');
      }
    } catch (e) {
      // Bắt các lỗi còn lại
      if (e.toString().contains('ERROR_INVALID_CREDENTIAL')) {
        _showError('Tài khoản hoặc mật khẩu không đúng');
      } else {
        _showError('Lỗi đăng nhập: $e');
      }
    } finally {
      loading.value = false;
    }
  }

  /// Tiếp tục dưới dạng khách
  Future<void> continueAsGuest() async {
    loading.value = true;
    try {
      final cred = await _auth.signInAnonymously();
      if (cred != null) {
        box.write("token", cred.user?.uid);
        box.write("guest", true);
        box.write("rememberMe", false);
        Get.offAllNamed(AppRoutes.home);
      } else {
        _showError('Không thể đăng nhập ẩn danh');
      }
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Đăng nhập khách thất bại');
    } catch (e) {
      _showError('Lỗi đăng nhập khách: $e');
    } finally {
      loading.value = false;
    }
  }

  /// Hiện/ẩn mật khẩu
  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  /// Hiển thị lỗi qua Snackbar
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
