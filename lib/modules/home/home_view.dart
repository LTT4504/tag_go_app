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
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 64,
        titleSpacing: 12,
        automaticallyImplyLeading: false,
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.textWhite,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.textWhite),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Tìm kiếm địa điểm...",
                    hintStyle: const TextStyle(color: Colors.black54),
                    prefixIcon:
                        const Icon(Icons.search, color: Colors.black87),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.tune, color: Colors.black87),
                      onPressed: () {},
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none,
                  color: Colors.black87, size: 28),
              onPressed: () {
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
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                          child: const PulseMarker(),
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
                bottom: 120,
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

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 25),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.darkPinkColor,
              width: 2,
            ),
            color: AppColors.textWhite.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircleButton(
                  Icons.list_alt,
                  () {
                    Get.toNamed(AppRoutes.myMap);
                  },
                  size: 45, 
                ),
                _buildCircleButton(
                  Icons.group,
                  () {
                    Get.toNamed(AppRoutes.friendsMap);
                  },
                  size: 45, 
                ),
                _buildCircleButton(
                  Icons.add_location_alt,
                  () {
                    controller.goAddSpot();
                  },
                  bgColor: AppColors.darkPinkColor,
                  iconColor: AppColors.textWhite,
                  size: 60, 
                ),
                _buildCircleButton(
                  Icons.person,
                  () {
                    Get.toNamed(AppRoutes.profile);
                  },
                  size: 45, 
                ),
                _buildCircleButton(
                  Icons.settings,
                  () {
                    Get.toNamed(AppRoutes.settings);
                  },
                  size: 45, 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onTap,
      {Color bgColor = Colors.white, Color iconColor = Colors.black87, double size = 50}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 26),
      ),
    );
  }
}
