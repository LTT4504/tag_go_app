import 'package:get/get.dart';
import 'package:taggo/api/api.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(ApiServices(), permanent: true);
  }
}