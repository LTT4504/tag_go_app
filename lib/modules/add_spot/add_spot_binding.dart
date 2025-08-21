import 'package:get/get.dart';
import 'add_spot_controller.dart';

class AddSpotBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddSpotController());
  }
}
