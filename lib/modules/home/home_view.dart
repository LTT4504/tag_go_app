import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'home_controller.dart';
import '../../routes/app_routes.dart';
import '../../shared/constants/colors.dart';
import '../../shared/widgets/pulse_marker.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // 👈 cho phép body tràn xuống dưới BottomAppBar
      appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 2,
  shadowColor: Colors.black12,
  toolbarHeight: 64,
  titleSpacing: 12,
  title: Row(
    children: [
      // 🔎 Ô tìm kiếm
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Tìm kiếm địa điểm...",
              hintStyle: const TextStyle(color: Colors.black54),
              prefixIcon: const Icon(Icons.search, color: Colors.black87),
              suffixIcon: IconButton(
                icon: const Icon(Icons.tune, color: Colors.black87),
                onPressed: () {
                  // TODO: filter
                },
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onSubmitted: (value) {
              // controller.searchPlaces(value);
            },
          ),
        ),
      ),

      // 🔔 Nút chuông thông báo
      IconButton(
        icon: const Icon(Icons.notifications_none, color: Colors.black87, size: 28),
        onPressed: () {
          // TODO: mở màn hình thông báo
          Get.snackbar("Thông báo", "Chưa có thông báo mới!");
        },
      ),
    ],
  ),
),


      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, AppColors.pastelYellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          final userPos = controller.currentPosition.value;

          return Stack(
            children: [
              // Bản đồ
              FlutterMap(
                mapController: controller.mapController,
                options: const MapOptions(
                  initialCenter: LatLng(10.762622, 106.660172),
                  initialZoom: 14,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.taggo',
                  ),
                  MarkerLayer(
                    markers: [
                      if (userPos != null) ...[
                        Marker(
                          point: userPos,
                          width: 60,
                          height: 60,
                          child: const Icon(
                            Icons.my_location,
                            color: Colors.blue,
                            size: 38,
                          ),
                        ),
                        Marker(
                          point: userPos,
                          width: 100,
                          height: 100,
                          child: const PulseMarker(), // 👈 hiệu ứng gợn sóng
                        ),
                      ],
                      ...controller.spots.map(
                        (s) => Marker(
                          point: LatLng(s.lat, s.lng),
                          width: 52,
                          height: 52,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.redAccent,
                            size: 42,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // 👉 Nút quay về vị trí hiện tại
              Positioned(
                bottom: 90,
                right: 16,
                child: FloatingActionButton(
                  heroTag: "refresh",
                  backgroundColor: Colors.white,
                  elevation: 6,
                  onPressed: () => controller.refreshLocation(),
                  child: const Icon(
                    Icons.gps_fixed,
                    color: AppColors.pinkColor,
                    size: 30,
                  ),
                ),
              ),
            ],
          );
        }),
      ),

      bottomNavigationBar: BottomAppBar(
  color: Colors.transparent,
  elevation: 0,
  child: ClipRRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // 👈 kính mờ iOS
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.list_alt, "Danh sách", () => Get.toNamed(AppRoutes.myMap)),
            _buildNavItem(Icons.group, "Bạn bè", () => Get.toNamed(AppRoutes.friendsMap)),

            // 👇 Nút thêm nằm trong bar luôn
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.pinkColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.add_location_alt, color: Colors.white, size: 28),
                onPressed: controller.goAddSpot,
              ),
            ),

            _buildNavItem(Icons.person, "Hồ sơ", () => Get.toNamed(AppRoutes.profile)),
            _buildNavItem(Icons.settings, "Cài đặt", () => Get.toNamed(AppRoutes.settings)),
          ],
        ),
      ),
    ),
  ),
),
    );
  }

  // Helper method for building navigation bar items
  Widget _buildNavItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black87, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
