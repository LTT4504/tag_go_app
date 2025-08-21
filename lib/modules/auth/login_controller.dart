import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../shared/service/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _auth = AuthService();
  var loading = false.obs;
  var error = ''.obs;

  Future<void> loginWithGoogle() async {
    loading.value = true;
    error.value = '';
    try {
      final cred = await _auth.signInWithGoogle();
      if (cred != null) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        error.value = 'Đăng nhập bị huỷ.';
      }
    } catch (e) {
      error.value = 'Lỗi: $e';
    } finally {
      loading.value = false;
    }
  }

  Future<void> continueAsGuest() async {
    loading.value = true;
    error.value = '';
    try {
      await _auth.signInAnonymously();
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      error.value = 'Lỗi: $e';
    } finally {
      loading.value = false;
    }
  }
}
