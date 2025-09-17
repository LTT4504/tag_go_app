import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../models/spot_model.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController {
  final spots = <Spot>[].obs;
  var currentPosition = Rxn<LatLng>();
  final mapController = MapController(); // 👈 thêm controller

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentPosition.value = LatLng(pos.latitude, pos.longitude);

    // 👇 Khi có vị trí thì move map tới vị trí đó
    if (currentPosition.value != null) {
      mapController.move(currentPosition.value!, 16);
    }
  }

  Future<void> refreshLocation() async {
    await _getCurrentLocation();
  }

  void goAddSpot() {
    Get.toNamed(AppRoutes.addSpot);
  }

  void openSpot(Spot s) {
    Get.toNamed(AppRoutes.spotDetail, arguments: s);
  }
}
