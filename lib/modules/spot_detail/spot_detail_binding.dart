import 'package:get/get.dart';
import 'spot_detail_controller.dart';

class SpotDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SpotDetailController());
  }
}
