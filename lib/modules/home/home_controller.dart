import 'dart:async';
import 'dart:developer'; 
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../models/spot_model.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController {
  final spots = <Spot>[].obs;
  final currentPosition = Rxn<LatLng>();
  final mapController = MapController();

  final isLoadingLocation = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      isLoadingLocation.value = true;
      log('Bắt đầu lấy vị trí...');

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      log('Dịch vụ định vị: $serviceEnabled');
      if (!serviceEnabled) {
        Get.snackbar('Lỗi', 'Vui lòng bật GPS để định vị vị trí hiện tại');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      log('Quyền hiện tại: $permission');

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        log('Quyền sau khi xin: $permission');
        if (permission == LocationPermission.denied) {
          Get.snackbar('Từ chối', 'Ứng dụng cần quyền truy cập vị trí');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar('Lỗi', 'Bạn đã chặn quyền vị trí vĩnh viễn');
        return;
      }

      final lastPos = await Geolocator.getLastKnownPosition();
      if (lastPos != null) {
        log('Dùng vị trí cũ: ${lastPos.latitude}, ${lastPos.longitude}');
        currentPosition.value = LatLng(lastPos.latitude, lastPos.longitude);
        mapController.move(currentPosition.value!, 16);
      }

      log('Đang lấy vị trí mới...');
     final pos = await Geolocator.getCurrentPosition(
  locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.medium,
  ),
);


      log('Vị trí mới: ${pos.latitude}, ${pos.longitude}');
      currentPosition.value = LatLng(pos.latitude, pos.longitude);
      mapController.move(currentPosition.value!, 16);
    } catch (e, stack) {
      log('Lỗi lấy vị trí: $e', stackTrace: stack);
      Get.snackbar('Lỗi', 'Không thể xác định vị trí hiện tại');
    } finally {
      isLoadingLocation.value = false;
      log('Hoàn tất lấy vị trí');
    }
  }

  Future<void> refreshLocation() async {
    log('Làm mới vị trí...');
    await _getCurrentLocation();
  }

  void goAddSpot() {
    log('Chuyển đến trang thêm Spot');
    Get.toNamed(AppRoutes.addSpot);
  }

  void openSpot(Spot s) {
    log('Mở chi tiết Spot: ${s.name}');
    Get.toNamed(AppRoutes.spotDetail, arguments: s);
  }
}
