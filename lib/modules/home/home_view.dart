import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../shared/constants/colors.dart';
import '../../shared/widgets/pulse_marker.dart';
import 'home_controller.dart';
import 'package:latlong2/latlong.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 64,
      titleSpacing: 12,
      automaticallyImplyLeading: false,
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
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
                controller: controller.searchController,
                onSubmitted: (_) => controller.onSearch(),
                decoration: InputDecoration(
                  hintText: "Tìm kiếm địa điểm...",
                  hintStyle: const TextStyle(color: Colors.black54),
                  prefixIcon: const Icon(Icons.search, color: Colors.black87),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tune, color: Colors.black87),
                    onPressed: controller.onSearch,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black87,
              size: 28,
            ),
            onPressed: controller.showNotification,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
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
                        child: const PulseMarker(),
                      ),
                    ],
                    ...controller.spots.map(
                      (s) => Marker(
                        point: LatLng(s.lat, s.lng),
                        width: 60,
                        height: 60,
                        child: Column(
                          children: [
                            Text(
                              s.name,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _getSpotColor(s.placeType),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                _getSpotIcon(s.placeType),
                                color: _getSpotColor(s.placeType),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 120,
              right: 16,
              child: FloatingActionButton(
                heroTag: "refresh",
                backgroundColor: Colors.white,
                elevation: 6,
                onPressed: controller.refreshLocation,
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
    );
  }

  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 25),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.darkPinkColor, width: 2),
          color: AppColors.textWhite.withOpacity(0.2),
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
              _circleButton(Icons.list_alt, controller.goMyMap, 45),
              _circleButton(Icons.group, controller.goFriendsMap, 45),
              _circleButton(
                Icons.add_location_alt,
                controller.goAddSpot,
                60,
                bgColor: AppColors.darkPinkColor,
                iconColor: AppColors.textWhite,
              ),
              _circleButton(Icons.person, controller.goProfile, 45),
              _circleButton(Icons.settings, controller.goSettings, 45),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleButton(
    IconData icon,
    VoidCallback onTap,
    double size, {
    Color bgColor = Colors.white,
    Color iconColor = Colors.black87,
  }) {
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

  IconData _getSpotIcon(String? type) {
    switch (type) {
      case 'drink':
        return Icons.local_cafe_rounded;
      case 'food':
        return Icons.restaurant_rounded;
      case 'home':
        return Icons.home_rounded;
      case 'game':
        return Icons.sports_esports_rounded;
      case 'movie':
        return Icons.movie;
      default:
        return Icons.location_pin;
    }
  }

  Color _getSpotColor(String? type) {
    switch (type) {
      case 'drink':
        return Colors.brown;
      case 'food':
        return Colors.orangeAccent;
      case 'home':
        return Colors.blueAccent;
      case 'game':
        return Colors.purpleAccent;
      case 'movie':
        return Colors.green;
      default:
        return Colors.redAccent;
    }
  }
}
