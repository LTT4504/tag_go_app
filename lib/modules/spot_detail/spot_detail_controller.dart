import 'package:get/get.dart';
import '../../models/spot_model.dart';

class SpotDetailController extends GetxController {
  late final Spot spot;

  @override
  void onInit() {
    super.onInit();
    spot = Get.arguments as Spot;
  }
}
