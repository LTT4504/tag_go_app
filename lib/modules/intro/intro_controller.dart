import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../routes/app_routes.dart';

class IntroController extends GetxController {
  final page = 0.obs;
  final box = GetStorage();

  void next() => page.value++;
  void skip() {
    box.write('seenIntro', true);
    Get.offAllNamed(AppRoutes.login);
  }

  void done() => skip();
}
