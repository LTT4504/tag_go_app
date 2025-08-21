import 'package:get/get.dart';
import '../../models/spot_model.dart';

class MyMapController extends GetxController {
  final filters = <String, String>{}.obs;
  final items = <Spot>[].obs;

  // TODO: load từ Firestore sau
  @override
  void onInit() {
    super.onInit();
    items.assignAll([]);
  }
}
