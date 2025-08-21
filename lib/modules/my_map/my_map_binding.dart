import 'package:get/get.dart';
import 'my_map_controller.dart';

class MyMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyMapController());
  }
}
