import 'package:get/get.dart';
import '../../shared/service/auth_service.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Đăng ký AuthService & Controller
    Get.lazyPut(() => AuthService());
    Get.put(LoginController(Get.find<AuthService>()));
  }
}
