import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import '../../routes/app_routes.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTE: Thay Container bằng GoogleMap khi bạn đã cấu hình google_maps_flutter
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bản đồ'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.myMap),
            icon: const Icon(Icons.list_alt),
          ),
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.friendsMap),
            icon: const Icon(Icons.group),
          ),
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.profile),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Obx(() => Stack(
        children: [
          Container(
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: const Text('Map Placeholder (GoogleMap ở đây)'),
          ),
          // bạn có thể overlay marker custom… ở đây – demo list ở dưới
          if (controller.spots.isEmpty)
            const Positioned(
              bottom: 100, left: 16, right: 16,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Chưa có địa điểm nào. Ấn nút + để thêm!'),
                ),
              ),
            ),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.goAddSpot,
        icon: const Icon(Icons.add_location_alt),
        label: const Text('Thêm địa điểm'),
      ),
    );
  }
}
