import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(seconds: 2)); // hiệu ứng loading logo
    final user = _auth.currentUser;

    if (user != null) {
      // ✅ Nếu đã đăng nhập thì vào Home
      Get.offAllNamed(AppRoutes.home);
    } else {
      // 🔒 Nếu chưa thì vào Login
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
