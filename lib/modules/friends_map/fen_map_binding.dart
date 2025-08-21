import 'package:get/get.dart';
import 'fen_map_controller.dart';

class FriendsMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FriendsMapController());
  }
}
