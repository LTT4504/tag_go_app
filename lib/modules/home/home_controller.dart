import 'package:get/get.dart';
import '../../models/spot_model.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController {
  // Tạm mock danh sách spot
  final spots = <Spot>[].obs;

  void goAddSpot() {
    Get.toNamed(AppRoutes.addSpot);
  }

  void openSpot(Spot s) {
    Get.toNamed(AppRoutes.spotDetail, arguments: s);
  }
}
