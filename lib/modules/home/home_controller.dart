import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import '../../models/spot_model.dart';
import '../../routes/app_routes.dart';
import '../base/base_controller.dart';
import '../add_spot/add_spot_bottomsheet.dart';

class HomeController extends BaseController<void> {
  HomeController() : super(null);

  // Danh sách các điểm Spot trên bản đ
  final spots = <Spot>[].obs;

  // Vị trí hiện tại của người dùng
  final currentPosition = Rxn<LatLng>();

  // Controller cho bản đồ
  final mapController = MapController();

  // Trạng thái đang tải vị trí
  final isLoadingLocation = false.obs;

  // Controller cho ô tìm kiếm
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation(); // Lấy vị trí ngay khi mở trang
  }

  /// 📍 Hàm lấy vị trí hiện tại của người dùng
  Future<void> _getCurrentLocation() async {
    try {
      isLoadingLocation.value = true;
      log('Bắt đầu lấy vị trí...');

      // Kiểm tra GPS đã bật chưa
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showError('Lỗi', 'Vui lòng bật GPS để định vị vị trí hiện tại');
        return;
      }

      // Kiểm tra quyền truy cập vị trí
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showError('Từ chối', 'Ứng dụng cần quyền truy cập vị trí');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showError('Lỗi', 'Bạn đã chặn quyền vị trí vĩnh viễn');
        return;
      }

      final lastPos = await Geolocator.getLastKnownPosition();
      if (lastPos != null) {
        currentPosition.value = LatLng(lastPos.latitude, lastPos.longitude);
        mapController.move(currentPosition.value!, 16);
      }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );

      currentPosition.value = LatLng(pos.latitude, pos.longitude);

      mapController.move(currentPosition.value!, 16);

      showSuccess('Thành công', 'Đã cập nhật vị trí hiện tại');
    } catch (e, stack) {
      log('Lỗi lấy vị trí: $e', stackTrace: stack);
      showError('Lỗi', 'Không thể xác định vị trí hiện tại');
    } finally {
      isLoadingLocation.value = false;
    }
  }

  Future<void> refreshLocation() async => await _getCurrentLocation();

  void goAddSpot() async => await showAddSpotBottomSheet();
  void goMyMap() => Get.toNamed(AppRoutes.myMap);
  void goFriendsMap() => Get.toNamed(AppRoutes.friendsMap);
  void goProfile() => Get.toNamed(AppRoutes.profile);
  void goSettings() => Get.toNamed(AppRoutes.settings);

  void onSearch() {
    final text = searchController.text.trim();
    if (text.isEmpty) {
      showError('Thông báo', 'Vui lòng nhập từ khóa tìm kiếm');
      return;
    }
    log('🔍 Đang tìm kiếm: $text');
  }

  void showNotification() {
    Get.snackbar("Thông báo", "Chưa có thông báo mới!");
  }

  void openSpot(Spot s) {
    log(' Mở chi tiết Spot: ${s.name}');
    Get.toNamed(AppRoutes.spotDetail, arguments: s);
  }

  @override
  Future getData() async {}

  Future<void> showAddSpotBottomSheet() async {
    final newSpot = await AddSpotBottomSheet.show(Get.context!);

    if (newSpot != null) {
      final pos = currentPosition.value;
      if (pos != null && (newSpot.lat == 0 || newSpot.lng == 0)) {
        newSpot.lat = pos.latitude;
        newSpot.lng = pos.longitude;
      }

      spots.add(newSpot);

      mapController.move(LatLng(newSpot.lat, newSpot.lng), 17);

      Get.snackbar(
        'Thành công',
        'Đã thêm địa điểm mới!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
