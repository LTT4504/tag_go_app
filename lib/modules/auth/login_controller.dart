import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../shared/service/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _auth = AuthService();

  // Trạng thái UI
  var loading = false.obs;
  var error = ''.obs;

  // Username & password
  var username = ''.obs;
  var password = ''.obs;

  // Hiển thị mật khẩu & ghi nhớ đăng nhập
  var showPassword = false.obs;
  var rememberMe = false.obs;

  /// Đăng nhập bằng username & password
  Future<void> login() async {
    if (username.value.isEmpty || password.value.isEmpty) {
      error.value = 'Vui lòng nhập đầy đủ thông tin';
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
        // Nếu người dùng chọn ghi nhớ đăng nhập
        if (rememberMe.value) {
          // TODO: Lưu token hoặc thông tin user vào GetStorage/SharedPreferences
        }
        Get.offAllNamed(AppRoutes.home);
      } else {
        error.value = 'Sai username hoặc mật khẩu';
      }
    } catch (e) {
      error.value = 'Lỗi đăng nhập: $e';
    } finally {
      loading.value = false;
    }
  }

  /// Đăng nhập bằng Google
  Future<void> loginWithGoogle() async {
    loading.value = true;
    error.value = '';
    try {
      final cred = await _auth.signInWithGoogle();
      if (cred != null) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        error.value = 'Đăng nhập bị huỷ';
      }
    } catch (e) {
      error.value = 'Lỗi đăng nhập Google: $e';
    } finally {
      loading.value = false;
    }
  }

  /// Tiếp tục dưới dạng khách
  Future<void> continueAsGuest() async {
    loading.value = true;
    error.value = '';
    try {
      final cred = await _auth.signInAnonymously();
      if (cred != null) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        error.value = 'Không thể đăng nhập ẩn danh';
      }
    } catch (e) {
      error.value = 'Lỗi đăng nhập khách: $e';
    } finally {
      loading.value = false;
    }
  }
}
