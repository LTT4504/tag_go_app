import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../shared/service/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService _auth = AuthService();

  String get displayName => _auth.currentUser?.displayName ?? 'Guest';
  String? get email => _auth.currentUser?.email;

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(AppRoutes.login);
  }
}
