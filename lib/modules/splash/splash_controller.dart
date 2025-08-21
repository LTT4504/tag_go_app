import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  final box = GetStorage();

  @override
  void onReady() {
    super.onReady();
    _next();
  }

  Future<void> _next() async {
    await Future.delayed(const Duration(seconds: 2));
    final seenIntro = box.read('seenIntro') == true;
    if (seenIntro) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.offAllNamed(AppRoutes.intro);
    }
  }
}
